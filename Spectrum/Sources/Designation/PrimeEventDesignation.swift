// MARK: - Module Dependency

import Foundation

// MARK: - Body

public enum PrimeEventDesignation: String, Sendable, CaseIterable {

#if DEBUG
    case observationButtonTapped
#endif

    /// 앱이 실행되었다.
    case appLaunched

    case timeElapsed

    case audioSessionInterruptionBegan
    case audioSessionInterruptionEnded
    case audioSessionRouteChanged
    case audioSessionMediaServicesWereReset

    case restorationPlateForceUpdateDialogOkButtonTapped
    case restorationPlateUpdateRecommendationDialogLaterButtonTapped
    case restorationPlateUpdateRecommendationDialogUpdateButtonTapped

    case mainPlateGameStartButtonTapped
    case mainPlateSettingsButtonTapped
    case mainPlateIdfaAuthorizationGranted
    case mainPlateIdfaAuthorizationDenied

    case basicGamePlateBackButtonTapped

    case settingsPlateCloseButtonTapped
    case settingsPlateBackgroundMusicToggleTapped
    case settingsPlateBackgroundMusicSlideSet
    case settingsPlateBackgroundMusicSlideFinishedEditing
    case settingsPlateSoundEffectToggleTapped
    case settingsPlateSoundEffectSlideSet
    case settingsPlateSoundEffectSlideFinishedEditing
    case settingsPlateHapticFeedbackToggleTapped

    /// 두 prime event에 대응되는 작업을 병렬 실행해도 문제가 없다면 true를 반환한다.
    ///
    /// Category에 따른 판단보다 우선한다.
    public func isExceptionallyPerformCompatibleWith(_ another: PrimeEventDesignation) -> Bool {
        // 오래 걸릴 것으로 기대되는 작업이 끝나기 전에 특정 유저 인터랙션을 미리 허용하고 싶을 때 사용하면 적절하다.
        return false
    }

    /// 두 prime event가 prime event 큐에 공존해도 괜찮다면 true를 반환한다.
    ///
    /// Category에 따른 판단보다 우선한다.
    public func isExceptionallyWaitCompatibleWith(_ another: PrimeEventDesignation) -> Bool {
        if isExceptionallyPerformCompatibleWith(another) {
            return true
        }
        // 유저의 빠른 연속 조작을 누락하지 않아야 할 때 사용하면 적절하다.
        switch self {
        case .settingsPlateBackgroundMusicSlideSet:
            switch another {
            case .settingsPlateBackgroundMusicSlideFinishedEditing:
                return true
            default:
                return false
            }
        case .settingsPlateSoundEffectSlideSet:
            switch another {
            case .settingsPlateSoundEffectSlideFinishedEditing:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }

    public var category: Category {
        switch self {
#if DEBUG
        case .observationButtonTapped:
                .natural
#endif
        case .appLaunched:
                .hierarchical(scale: .app)
        case .timeElapsed:
                .natural
        case .audioSessionInterruptionBegan:
                .natural
        case .audioSessionInterruptionEnded:
                .natural
        case .audioSessionRouteChanged:
                .natural
        case .audioSessionMediaServicesWereReset:
                .natural
        case .restorationPlateForceUpdateDialogOkButtonTapped:
                .hierarchical(scale: .app)
        case .restorationPlateUpdateRecommendationDialogLaterButtonTapped:
                .hierarchical(scale: .interplate)
        case .restorationPlateUpdateRecommendationDialogUpdateButtonTapped:
                .hierarchical(scale: .app)
        case .mainPlateGameStartButtonTapped:
                .hierarchical(scale: .interplate)
        case .mainPlateSettingsButtonTapped:
                .hierarchical(scale: .interplate)
        case .mainPlateIdfaAuthorizationGranted:
                .hierarchical(scale: .boundedInPlate)
        case .mainPlateIdfaAuthorizationDenied:
                .hierarchical(scale: .boundedInPlate)
        case .basicGamePlateBackButtonTapped:
                .hierarchical(scale: .interplate)
        case .settingsPlateCloseButtonTapped:
                .hierarchical(scale: .interplate)
        case .settingsPlateBackgroundMusicToggleTapped:
                .hierarchical(scale: .boundedInPlate)
        case .settingsPlateBackgroundMusicSlideSet:
                .hierarchical(scale: .boundedInPlate)
        case .settingsPlateBackgroundMusicSlideFinishedEditing:
                .hierarchical(scale: .boundedInPlate)
        case .settingsPlateSoundEffectToggleTapped:
                .hierarchical(scale: .boundedInPlate)
        case .settingsPlateSoundEffectSlideSet:
                .hierarchical(scale: .boundedInPlate)
        case .settingsPlateSoundEffectSlideFinishedEditing:
                .hierarchical(scale: .boundedInPlate)
        case .settingsPlateHapticFeedbackToggleTapped:
                .hierarchical(scale: .boundedInPlate)
        }
    }

    public enum Category {

        /// 항상 enqueue된다. 큐에 있더라도 다른 prime event가 enqueue되는 것을 방해하지 않는다.
        case natural
        /// 큐에 있는 모든 hierarchical prime event보다 스케일이 커야 enqueue될 수 있다.
        case hierarchical(scale: Scale)

        public enum Scale: Int {

            case boundedInPlate = 0
            case interplate = 1
            case app = 2
        }
    }
}

public enum PrimeEventDesignationWithPayload: Sendable {

#if DEBUG
    case observationButtonTapped
#endif

    /// 앱이 실행되었다.
    case appLaunched

    case timeElapsed(now: Date)

    case audioSessionInterruptionBegan
    case audioSessionInterruptionEnded
    case audioSessionRouteChanged
    case audioSessionMediaServicesWereReset

    case restorationPlateForceUpdateDialogOkButtonTapped
    case restorationPlateUpdateRecommendationDialogLaterButtonTapped
    case restorationPlateUpdateRecommendationDialogUpdateButtonTapped

    case mainPlateGameStartButtonTapped
    case mainPlateSettingsButtonTapped
    case mainPlateIdfaAuthorizationGranted
    case mainPlateIdfaAuthorizationDenied

    case basicGamePlateBackButtonTapped

    case settingsPlateCloseButtonTapped
    case settingsPlateBackgroundMusicToggleTapped
    case settingsPlateBackgroundMusicSlideSet(value: Double)
    case settingsPlateBackgroundMusicSlideFinishedEditing
    case settingsPlateSoundEffectToggleTapped
    case settingsPlateSoundEffectSlideSet(value: Double)
    case settingsPlateSoundEffectSlideFinishedEditing
    case settingsPlateHapticFeedbackToggleTapped

    public var designation: PrimeEventDesignation {
        switch self {
#if DEBUG
        case .observationButtonTapped:
                .observationButtonTapped
#endif
        case .appLaunched:
                .appLaunched
        case .timeElapsed:
                .timeElapsed
        case .audioSessionInterruptionBegan:
                .audioSessionInterruptionBegan
        case .audioSessionInterruptionEnded:
                .audioSessionInterruptionEnded
        case .audioSessionRouteChanged:
                .audioSessionRouteChanged
        case .audioSessionMediaServicesWereReset:
                .audioSessionMediaServicesWereReset
        case .restorationPlateForceUpdateDialogOkButtonTapped:
                .restorationPlateForceUpdateDialogOkButtonTapped
        case .restorationPlateUpdateRecommendationDialogLaterButtonTapped:
                .restorationPlateUpdateRecommendationDialogLaterButtonTapped
        case .restorationPlateUpdateRecommendationDialogUpdateButtonTapped:
                .restorationPlateUpdateRecommendationDialogUpdateButtonTapped
        case .mainPlateGameStartButtonTapped:
                .mainPlateGameStartButtonTapped
        case .mainPlateSettingsButtonTapped:
                .mainPlateSettingsButtonTapped
        case .mainPlateIdfaAuthorizationGranted:
                .mainPlateIdfaAuthorizationGranted
        case .mainPlateIdfaAuthorizationDenied:
                .mainPlateIdfaAuthorizationDenied
        case .basicGamePlateBackButtonTapped:
                .basicGamePlateBackButtonTapped
        case .settingsPlateCloseButtonTapped:
                .settingsPlateCloseButtonTapped
        case .settingsPlateBackgroundMusicToggleTapped:
                .settingsPlateBackgroundMusicToggleTapped
        case .settingsPlateBackgroundMusicSlideSet:
                .settingsPlateBackgroundMusicSlideSet
        case .settingsPlateBackgroundMusicSlideFinishedEditing:
                .settingsPlateBackgroundMusicSlideFinishedEditing
        case .settingsPlateSoundEffectToggleTapped:
                .settingsPlateSoundEffectToggleTapped
        case .settingsPlateSoundEffectSlideSet:
                .settingsPlateSoundEffectSlideSet
        case .settingsPlateSoundEffectSlideFinishedEditing:
                .settingsPlateSoundEffectSlideFinishedEditing
        case .settingsPlateHapticFeedbackToggleTapped:
                .settingsPlateHapticFeedbackToggleTapped
        }
    }
}
