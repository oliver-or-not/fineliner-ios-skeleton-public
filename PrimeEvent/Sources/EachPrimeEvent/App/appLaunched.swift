// MARK: - Module Dependency

import Foundation
import Universe
import Spectrum
import Director
import Agent
import Plate
import PrimeEventBase

// MARK: - Context

fileprivate let logDirector = GlobalEntity.Director.log

fileprivate let networkAgent = GlobalEntity.Agent.networkAgent
fileprivate let dateAgent = GlobalEntity.Agent.dateAgent
fileprivate let appStateAgent = GlobalEntity.Agent.appStateAgent
fileprivate let appInfoAgent = GlobalEntity.Agent.appInfoAgent
fileprivate let idfaAgent = GlobalEntity.Agent.idfaAgent
fileprivate let googleAdAgent = GlobalEntity.Agent.googleAdAgent
fileprivate let plateStackAgent = GlobalEntity.Agent.plateStackAgent
fileprivate let soundAgent = GlobalEntity.Agent.soundAgent
@MainActor fileprivate let hapticFeedbackAgent = GlobalEntity.Agent.hapticFeedbackAgent
fileprivate let appSwitchAgent = GlobalEntity.Agent.appSwitchAgent

fileprivate let restorationPlate = GlobalEntity.Plate.restorationPlate
fileprivate let mainPlate = GlobalEntity.Plate.mainPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let appLaunched: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .appLaunched, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in

    // MARK: - Set Constants

    let now = await dateAgent.getNowDate()
    let buildNumber = await appInfoAgent.getBuildNumber()

    // MARK: - Activation

    await plateStackAgent.setActivationLevel(.active)

    // MARK: - Present Restoration Plate

    await plateStackAgent.pushPlate(.restoration, .withoutAnimation)

    // MARK: - Activation

    await dateAgent.setActivationLevel(.active)
    await appStateAgent.setActivationLevel(.active)
    await appInfoAgent.setActivationLevel(.active)
    await idfaAgent.setActivationLevel(.active)
    await hapticFeedbackAgent.setActivationLevel(.active)
    await appSwitchAgent.setActivationLevel(.active)

    let supabaseUrlString = await appInfoAgent.getSupabaseUrlString()
    let supabaseKey = await appInfoAgent.getSupabaseKey()

    await networkAgent.initSupabaseClient(
        supabaseUrl: URL(string: supabaseUrlString)!,
        supabaseKey: supabaseKey
    )

    await networkAgent.setActivationLevel(.active)

    await googleAdAgent.start()
    await googleAdAgent.setActivationLevel(.active)

    // MARK: - Before Migration

    let migratedBuildNumber = await appStateAgent.getMigratedBuildNumber()
    if migratedBuildNumber == nil {
        // 최초 실행인 경우. 현재 빌드 번호를 migratedBuildNumber로 지정한다.
        // 따라서 이 경우에는 마이그레이션이 진행되지 않는다.
        await appStateAgent.setMigratedBuildNumber(buildNumber)
    }

    // MARK: - Migration

    // MARK: - After Migration

    // 현재의 빌드 번호를 타겟으로 하는 마이그레이션 작업이 없더라도 현재의 빌드 번호를 migratedBuildNumber로 지정한다.
    await appStateAgent.setMigratedBuildNumber(buildNumber)

    // MARK: - Sound

    await soundAgent.setActivationLevel(.active)

    let isBackgroundMusicOn = await appStateAgent.getIsBackgroundMusicOn()
    await soundAgent.setIsBackgroundMusicOn(isBackgroundMusicOn)
    let backgroundMusicVolume = await appStateAgent.getBackgroundMusicVolume()
    await soundAgent.setBackgroundMusicVolume(Float(backgroundMusicVolume))
    let isSoundEffectOn = await appStateAgent.getIsSoundEffectOn()
    await soundAgent.setIsSoundEffectOn(isSoundEffectOn)
    let soundEffectVolume = await appStateAgent.getSoundEffectVolume()
    await soundAgent.setSoundEffectVolume(Float(soundEffectVolume))

    await soundAgent.playBackgroundMusic(.mainBackgroundMusic)

    // MARK: - Check Build Number Policy

    let isBuildNumberPolicyFetchedRecently: Bool
    let lastFetchedDateOfBuildNumberPolicy = await appStateAgent.getLastFetchedDateOfBuildNumberPolicy()
    if let lastFetchedDateOfBuildNumberPolicy {
        if lastFetchedDateOfBuildNumberPolicy.addingTimeInterval(60 * 60 * 24 * 3) < now {
            isBuildNumberPolicyFetchedRecently = false
        } else {
            isBuildNumberPolicyFetchedRecently = true
        }
    } else {
        isBuildNumberPolicyFetchedRecently = false
    }

    let isBuildNumberPolicyFetchRequired: Bool
    let buildNumberPolicy = await appStateAgent.getBuildNumberPolicy()
    if let buildNumberPolicy,
       buildNumber < buildNumberPolicy.minimumSupportedBuildNumber {
        isBuildNumberPolicyFetchRequired = false
    } else {
        if !isBuildNumberPolicyFetchedRecently {
            isBuildNumberPolicyFetchRequired = true
        } else {
            isBuildNumberPolicyFetchRequired = false
        }
    }

    if isBuildNumberPolicyFetchRequired {
        do {
            let buildNumberPolicyFromServer = try await networkAgent.fetchBuildNumberPolicy()
            await appStateAgent.setBuildNumberPolicy(buildNumberPolicyFromServer)
            await appStateAgent.setLastFetchedDateOfBuildNumberPolicy(now)
        } catch {
            await logDirector.primeEventLog(.appLaunched, .error, "Build number policy fetch failed: \(error)")
        }
    }

    let buildNumberPolicyAfterFetching = await appStateAgent.getBuildNumberPolicy()
    if let buildNumberPolicyAfterFetching {
        if buildNumber < buildNumberPolicyAfterFetching.minimumSupportedBuildNumber {
            await restorationPlate.showForceUpdateDialog()
        } else if buildNumber < buildNumberPolicyAfterFetching.minimumRecommendedBuildNumber {
            await restorationPlate.showUpdateRecommendationDialog()
        } else {

            // MARK: - Set Data into Records Plate

            let bannerAdUnitId = await appInfoAgent.getCustomGoogleAdUnitIdForMainPlateBottomBannerAd()
            await mainPlate.setBannerAdUnitId(bannerAdUnitId)

            // MARK: - Present Main Plate

            await plateStackAgent.pushPlate(.main, .fadeIn)

            // MARK: - Request IDFA Authorization or Show Banner Ad

            let idfaAuthorizationStatus = await idfaAgent.currentAuthorizationStatus()
            if case .notDetermined = idfaAuthorizationStatus {
                await idfaAgent.requestAuthorization()
            } else {
                await mainPlate.setIsBannerAdShown(true)
            }
        }
    }
}
