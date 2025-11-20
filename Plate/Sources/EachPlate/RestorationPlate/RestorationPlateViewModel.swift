// MARK: - Module Dependency

import SwiftUI

// MARK: - Body

@MainActor @Observable public final class RestorationPlateViewModel {

    public static let shared = RestorationPlateViewModel(
        isForceUpdateDialogShown: false,
        isUpdateRecommendationDialogShown: false
    )

    public internal(set) var isForceUpdateDialogShown: Bool
    public internal(set) var isUpdateRecommendationDialogShown: Bool

    init(
        isForceUpdateDialogShown: Bool,
        isUpdateRecommendationDialogShown: Bool
    ) {
        self.isForceUpdateDialogShown = isForceUpdateDialogShown
        self.isUpdateRecommendationDialogShown = isUpdateRecommendationDialogShown
    }
}
