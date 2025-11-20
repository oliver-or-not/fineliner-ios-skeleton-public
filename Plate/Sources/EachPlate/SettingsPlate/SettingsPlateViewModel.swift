// MARK: - Module Dependency

import SwiftUI
import Agent

// MARK: - Body

@MainActor @Observable public final class SettingsPlateViewModel {

    public static let shared = SettingsPlateViewModel(
        backgroundMusicToggleValue: false,
        backgroundMusicVolumeSliderValue: 0,
        isBackgroundMusicVolumeSliderAvailable: false,
        soundEffectToggleValue: false,
        soundEffectVolumeSliderValue: 0,
        isSoundEffectVolumeSliderAvailable: false,
        isHapticFeedbackOn: false
    )

    public internal(set) var backgroundMusicToggleValue: Bool
    public internal(set) var backgroundMusicVolumeSliderValue: Double
    public internal(set) var isBackgroundMusicVolumeSliderAvailable: Bool
    public internal(set) var soundEffectToggleValue: Bool
    public internal(set) var soundEffectVolumeSliderValue: Double
    public internal(set) var isSoundEffectVolumeSliderAvailable: Bool
    public internal(set) var hapticFeedbackToggleValue: Bool

    init(
        backgroundMusicToggleValue: Bool,
        backgroundMusicVolumeSliderValue: Double,
        isBackgroundMusicVolumeSliderAvailable: Bool,
        soundEffectToggleValue: Bool,
        soundEffectVolumeSliderValue: Double,
        isSoundEffectVolumeSliderAvailable: Bool,
        isHapticFeedbackOn: Bool
    ) {
        self.backgroundMusicToggleValue = backgroundMusicToggleValue
        self.backgroundMusicVolumeSliderValue = backgroundMusicVolumeSliderValue
        self.isBackgroundMusicVolumeSliderAvailable = isBackgroundMusicVolumeSliderAvailable
        self.soundEffectToggleValue = soundEffectToggleValue
        self.soundEffectVolumeSliderValue = soundEffectVolumeSliderValue
        self.isSoundEffectVolumeSliderAvailable = isSoundEffectVolumeSliderAvailable
        self.hapticFeedbackToggleValue = isHapticFeedbackOn
    }
}
