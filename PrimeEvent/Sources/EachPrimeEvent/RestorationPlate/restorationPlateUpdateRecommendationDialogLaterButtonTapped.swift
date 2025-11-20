// MARK: - Module Dependency

import Spectrum
import Agent
import Plate
import PrimeEventBase

// MARK: - Context

fileprivate let appInfoAgent = GlobalEntity.Agent.appInfoAgent
fileprivate let plateStackAgent = GlobalEntity.Agent.plateStackAgent
fileprivate let restorationPlate = GlobalEntity.Plate.restorationPlate
fileprivate let mainPlate = GlobalEntity.Plate.mainPlate
fileprivate let idfaAgent = GlobalEntity.Agent.idfaAgent

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let restorationPlateUpdateRecommendationDialogLaterButtonTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .restorationPlateUpdateRecommendationDialogLaterButtonTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in
    await restorationPlate.hideUpdateRecommendationDialog()

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
