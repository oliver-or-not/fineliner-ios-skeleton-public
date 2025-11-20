// MARK: - Module Dependency

import SwiftUI
import Agent

// MARK: - Body

@MainActor @Observable public final class MainPlateViewModel {

    public static let shared = MainPlateViewModel(
        bannerAdUnitId: nil,
        isBannerAdShown: false
    )

    public internal(set) var bannerAdUnitId: String?
    public internal(set) var isBannerAdShown: Bool

    init(
        bannerAdUnitId: String?,
        isBannerAdShown: Bool
    ) {
        self.bannerAdUnitId = bannerAdUnitId
        self.isBannerAdShown = isBannerAdShown
    }
}
