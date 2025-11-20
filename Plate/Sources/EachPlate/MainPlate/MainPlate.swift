// MARK: - Module Dependency

import Spectrum
import Director
import PlateBase

// MARK: - Context

@MainActor fileprivate let viewModel = MainPlateViewModel.shared

// MARK: - Body

extension GlobalEntity.Plate {

    public static let mainPlate: MainPlateInterface = MainPlate(
        bannerAdUnitId: nil,
        isBannerAdShown: false
    )
}

public protocol MainPlateInterface: GlobalEntity.Plate.Interface, Sendable {

    func setBannerAdUnitId(_ bannerAdUnitId: String?) async

    func setIsBannerAdShown(_ isBannerAdShown: Bool) async

    func reset() async
}

fileprivate final actor MainPlate: MainPlateInterface {

    // MARK: - GlobalEntity/Plate/Interface

    nonisolated let designation: PlateDesignation = .main

    // MARK: - MainPlateInterface

    func setBannerAdUnitId(_ bannerAdUnitId: String?) async {
        self.bannerAdUnitId = bannerAdUnitId
        await updateViewModel()
    }

    func setIsBannerAdShown(_ isBannerAdShown: Bool) async {
        self.isBannerAdShown = isBannerAdShown
        await updateViewModel()
    }

    func reset() async {
        bannerAdUnitId = nil
        isBannerAdShown = false
        await updateViewModel()
    }

    private func updateViewModel() async {
        let capturedIsBannerAdShown = isBannerAdShown
        let capturedBannerAdUnitId = bannerAdUnitId
        await MainActor.run {
            viewModel.isBannerAdShown = capturedIsBannerAdShown
            viewModel.bannerAdUnitId = capturedBannerAdUnitId
        }
    }

    // MARK: - Holding Property

    private var bannerAdUnitId: String?
    private var isBannerAdShown: Bool

    // MARK: - Lifecycle

    init(
        bannerAdUnitId: String?,
        isBannerAdShown: Bool
    ) {
        self.bannerAdUnitId = bannerAdUnitId
        self.isBannerAdShown = isBannerAdShown
    }
}

