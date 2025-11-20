// MARK: - Module Dependency

import Spectrum
import Director
import Agent
import Plate
import PrimeEventBase

// MARK: - Context

fileprivate let logDirector = GlobalEntity.Director.log

fileprivate let appInfoAgent = GlobalEntity.Agent.appInfoAgent
fileprivate let plateStackAgent = GlobalEntity.Agent.plateStackAgent
fileprivate let appSwitchAgent = GlobalEntity.Agent.appSwitchAgent
fileprivate let idfaAgent = GlobalEntity.Agent.idfaAgent

fileprivate let restorationPlate = GlobalEntity.Plate.restorationPlate
fileprivate let mainPlate = GlobalEntity.Plate.mainPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let restorationPlateUpdateRecommendationDialogUpdateButtonTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .restorationPlateUpdateRecommendationDialogUpdateButtonTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in
    await restorationPlate.hideUpdateRecommendationDialog()

    // MARK: - Set Data into Records Plate

    let bannerAdUnitId = await appInfoAgent.getCustomGoogleAdUnitIdForMainPlateBottomBannerAd()
    await mainPlate.setBannerAdUnitId(bannerAdUnitId)

    // MARK: - Present Main Plate

    await plateStackAgent.pushPlate(.main, .fadeIn)

    // MARK: - Show Banner Ad

    // 여기서 IDFA 권한을 물으면 너무 이상하다. 따라서 묻지 않는다.
    await mainPlate.setIsBannerAdShown(true)

    // MARK: - Open App Store

    do {
        try await appSwitchAgent.switchTo(.appStorePageOfThisApp)
    } catch {
        await logDirector.primeEventLog(
            .restorationPlateUpdateRecommendationDialogUpdateButtonTapped,
            .error,
            "Failed to switch to App Store page of this app. error: \(error)"
        )
    }
}
