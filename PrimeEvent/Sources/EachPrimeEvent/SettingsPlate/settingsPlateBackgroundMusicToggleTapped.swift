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

    public static let settingsPlateBackgroundMusicToggleTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .settingsPlateBackgroundMusicToggleTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in
    let currentValue = await appStateAgent.getIsBackgroundMusicOn()

    await settingsPlate.setIsBackgroundMusicOn(!currentValue)
    await appStateAgent.setIsBackgroundMusicOn(!currentValue)
    await soundAgent.setIsBackgroundMusicOn(!currentValue)
}
