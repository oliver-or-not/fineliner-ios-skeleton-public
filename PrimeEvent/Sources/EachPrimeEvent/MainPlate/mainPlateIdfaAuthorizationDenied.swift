// MARK: - Module Dependency

import Spectrum
import Agent
import PrimeEventBase

// MARK: - Context

fileprivate let mainPlate = GlobalEntity.Plate.mainPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let mainPlateIdfaAuthorizationDenied: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .mainPlateIdfaAuthorizationDenied, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in

    await mainPlate.setIsBannerAdShown(true)
}
