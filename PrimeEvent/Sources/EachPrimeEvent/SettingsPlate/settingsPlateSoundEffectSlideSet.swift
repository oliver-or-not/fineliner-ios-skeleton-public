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

    public static let settingsPlateSoundEffectSlideSet: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .settingsPlateSoundEffectSlideSet, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { primeEventDesignationWithPayload in
    guard case .settingsPlateSoundEffectSlideSet(value: let slideValue) = primeEventDesignationWithPayload else {
        await logDirector.primeEventLog(
            .settingsPlateSoundEffectSlideSet,
            .error,
            "Designation mismatched. Received designation: \(primeEventDesignationWithPayload)"
        )
        return
    }

    await settingsPlate.setSoundEffectVolume(slideValue)
    await appStateAgent.setSoundEffectVolume(slideValue)
    await soundAgent.setSoundEffectVolume(Float(slideValue))
}
