// MARK: - Module Dependency

import SwiftUI
import Spectrum
import PlateBase

// MARK: - Context

@MainActor fileprivate let viewModel = BasicGamePlateViewModel.shared

// MARK: - Body

extension GlobalEntity.Plate {

    public static let basicGamePlate: BasicGamePlateInterface = BasicGamePlate()
}

public protocol BasicGamePlateInterface: GlobalEntity.Plate.Interface, Sendable {}

fileprivate final actor BasicGamePlate: NSObject, BasicGamePlateInterface {

    // MARK: - GlobalEntity/Plate/Interface

    nonisolated let designation: PlateDesignation = .basicGame

    // MARK: - Lifecycle

    fileprivate override init() {}
}
