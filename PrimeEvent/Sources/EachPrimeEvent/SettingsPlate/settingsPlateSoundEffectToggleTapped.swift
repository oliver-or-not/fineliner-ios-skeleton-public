// MARK: - Module Dependency

import Spectrum
import Agent
import PrimeEventBase

// MARK: - Context

fileprivate let soundAgent = GlobalEntity.Agent.soundAgent
fileprivate let appStateAgent = GlobalEntity.Agent.appStateAgent
fileprivate let settingsPlate = GlobalEntity.Plate.settingsPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let settingsPlateSoundEffectToggleTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .settingsPlateSoundEffectToggleTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in
    let currentValue = await appStateAgent.getIsSoundEffectOn()

    await settingsPlate.setIsSoundEffectOn(!currentValue)
    await appStateAgent.setIsSoundEffectOn(!currentValue)
    await soundAgent.setIsSoundEffectOn(!currentValue)
}
