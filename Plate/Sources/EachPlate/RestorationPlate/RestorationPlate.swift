// MARK: - Module Dependency

import Spectrum
import PlateBase

// MARK: - Context

@MainActor fileprivate let viewModel = RestorationPlateViewModel.shared

// MARK: - Body

extension GlobalEntity.Plate {

    public static let restorationPlate: RestorationPlateInterface = RestorationPlate(
        isForceUpdateDialogShown: false,
        isUpdateRecommendationDialogShown: false
    )
}

public protocol RestorationPlateInterface: GlobalEntity.Plate.Interface, Sendable {

    func showForceUpdateDialog() async
    func hideForceUpdateDialog() async
    func showUpdateRecommendationDialog() async
    func hideUpdateRecommendationDialog() async
}

fileprivate final actor RestorationPlate: RestorationPlateInterface {

    // MARK: - GlobalEntity/Plate/Interface

    nonisolated let designation: PlateDesignation = .restoration

    // MARK: - RestorationPlateInterface

    func showForceUpdateDialog() async {
        self.isForceUpdateDialogShown = true
        await updateViewModel()
    }

    func hideForceUpdateDialog() async {
        self.isForceUpdateDialogShown = false
        await updateViewModel()
    }

    func showUpdateRecommendationDialog() async {
        self.isUpdateRecommendationDialogShown = true
        await updateViewModel()
    }

    func hideUpdateRecommendationDialog() async {
        self.isUpdateRecommendationDialogShown = false
        await updateViewModel()
    }

    private func updateViewModel() async {
        let capturedIsForceUpdateDialogShown = isForceUpdateDialogShown
        let capturedIsUpdateRecommendationDialogShown = isUpdateRecommendationDialogShown
        await MainActor.run {
            viewModel.isForceUpdateDialogShown = capturedIsForceUpdateDialogShown
            viewModel.isUpdateRecommendationDialogShown = capturedIsUpdateRecommendationDialogShown
        }
    }

    // MARK: - Holding Property

    private var isForceUpdateDialogShown: Bool
    private var isUpdateRecommendationDialogShown: Bool

    // MARK: - Lifecycle

    init(
        isForceUpdateDialogShown: Bool,
        isUpdateRecommendationDialogShown: Bool
    ) {
        self.isForceUpdateDialogShown = isForceUpdateDialogShown
        self.isUpdateRecommendationDialogShown = isUpdateRecommendationDialogShown
    }
}
