// MARK: - Module Dependency

import Spectrum

// MARK: - Body

public extension PrimeEventDesignation {

    var interface: GlobalEntity.PrimeEvent.Interface {
        switch self {
#if DEBUG
        case .observationButtonTapped:
            GlobalEntity.PrimeEvent.observationButtonTapped
#endif
        case .appLaunched:
            GlobalEntity.PrimeEvent.appLaunched
        case .timeElapsed:
            GlobalEntity.PrimeEvent.timeElapsed
        case .audioSessionInterruptionBegan:
            GlobalEntity.PrimeEvent.audioSessionInterruptionBegan
        case .audioSessionInterruptionEnded:
            GlobalEntity.PrimeEvent.audioSessionInterruptionEnded
        case .audioSessionRouteChanged:
            GlobalEntity.PrimeEvent.audioSessionRouteChanged
        case .audioSessionMediaServicesWereReset:
            GlobalEntity.PrimeEvent.audioSessionMediaServicesWereReset
        case .restorationPlateForceUpdateDialogOkButtonTapped:
            GlobalEntity.PrimeEvent.restorationPlateForceUpdateDialogOkButtonTapped
        case .restorationPlateUpdateRecommendationDialogLaterButtonTapped:
            GlobalEntity.PrimeEvent.restorationPlateUpdateRecommendationDialogLaterButtonTapped
        case .restorationPlateUpdateRecommendationDialogUpdateButtonTapped:
            GlobalEntity.PrimeEvent.restorationPlateUpdateRecommendationDialogUpdateButtonTapped
        case .mainPlateGameStartButtonTapped:
            GlobalEntity.PrimeEvent.mainPlateGameStartButtonTapped
        case .mainPlateSettingsButtonTapped:
            GlobalEntity.PrimeEvent.mainPlateSettingsButtonTapped
        case .mainPlateIdfaAuthorizationGranted:
            GlobalEntity.PrimeEvent.mainPlateIdfaAuthorizationGranted
        case .mainPlateIdfaAuthorizationDenied:
            GlobalEntity.PrimeEvent.mainPlateIdfaAuthorizationDenied
        case .basicGamePlateBackButtonTapped:
            GlobalEntity.PrimeEvent.basicGamePlateBackButtonTapped
        case .settingsPlateCloseButtonTapped:
            GlobalEntity.PrimeEvent.settingsPlateCloseButtonTapped
        case .settingsPlateBackgroundMusicToggleTapped:
            GlobalEntity.PrimeEvent.settingsPlateBackgroundMusicToggleTapped
        case .settingsPlateBackgroundMusicSlideSet:
            GlobalEntity.PrimeEvent.settingsPlateBackgroundMusicSlideSet
        case .settingsPlateBackgroundMusicSlideFinishedEditing:
            GlobalEntity.PrimeEvent.settingsPlateBackgroundMusicSlideFinishedEditing
        case .settingsPlateSoundEffectToggleTapped:
            GlobalEntity.PrimeEvent.settingsPlateSoundEffectToggleTapped
        case .settingsPlateSoundEffectSlideSet:
            GlobalEntity.PrimeEvent.settingsPlateSoundEffectSlideSet
        case .settingsPlateSoundEffectSlideFinishedEditing:
            GlobalEntity.PrimeEvent.settingsPlateSoundEffectSlideFinishedEditing
        case .settingsPlateHapticFeedbackToggleTapped:
            GlobalEntity.PrimeEvent.settingsPlateHapticFeedbackToggleTapped
        }
    }
}
