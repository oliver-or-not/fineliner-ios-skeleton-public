// MARK: - Module Dependency

import Spectrum
import Agent
import PrimeEventBase

// MARK: - Context

fileprivate let plateStackAgent = GlobalEntity.Agent.plateStackAgent
fileprivate let appStateAgent = GlobalEntity.Agent.appStateAgent
fileprivate let settingsPlate = GlobalEntity.Plate.settingsPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let mainPlateSettingsButtonTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .mainPlateSettingsButtonTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in

    // MARK: - Set Data into Settings Plate

    let isBackgroundMusicOn = await appStateAgent.getIsBackgroundMusicOn()
    await settingsPlate.setIsBackgroundMusicOn(isBackgroundMusicOn)
    let backgroundMusicVolume = await appStateAgent.getBackgroundMusicVolume()
    await settingsPlate.setBackgroundMusicVolume(backgroundMusicVolume)
    let isSoundEffectOn = await appStateAgent.getIsSoundEffectOn()
    await settingsPlate.setIsSoundEffectOn(isSoundEffectOn)
    let soundEffectVolume = await appStateAgent.getSoundEffectVolume()
    await settingsPlate.setSoundEffectVolume(soundEffectVolume)
    let isHapticFeedbackOn = await appStateAgent.getIsHapticFeedbackOn()
    await settingsPlate.setIsHapticFeedbackOn(isHapticFeedbackOn)

    // MARK: - Present Settings Plate

    await plateStackAgent.pushPlate(.settings, .fromBottom)
}
