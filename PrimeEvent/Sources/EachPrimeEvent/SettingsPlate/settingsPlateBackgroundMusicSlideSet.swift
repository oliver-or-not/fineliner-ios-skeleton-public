// MARK: - Module Dependency

import Spectrum
import Director
import Agent
import PrimeEventBase

// MARK: - Context

fileprivate let logDirector = GlobalEntity.Director.log

fileprivate let soundAgent = GlobalEntity.Agent.soundAgent
fileprivate let appStateAgent = GlobalEntity.Agent.appStateAgent

fileprivate let settingsPlate = GlobalEntity.Plate.settingsPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let settingsPlateBackgroundMusicSlideSet: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .settingsPlateBackgroundMusicSlideSet, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { primeEventDesignationWithPayload in
    guard case .settingsPlateBackgroundMusicSlideSet(value: let slideValue) = primeEventDesignationWithPayload else {
        await logDirector.primeEventLog(
            .settingsPlateBackgroundMusicSlideSet,
            .error,
            "Designation mismatched. Received designation: \(primeEventDesignationWithPayload)"
        )
        return
    }

    await settingsPlate.setBackgroundMusicVolume(slideValue)
    await appStateAgent.setBackgroundMusicVolume(slideValue)
    await soundAgent.setBackgroundMusicVolume(Float(slideValue))
}
