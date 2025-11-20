// MARK: - Module Dependency

import Spectrum
import Agent
import PlateBase

// MARK: - Context

@MainActor fileprivate let viewModel = SettingsPlateViewModel.shared

// MARK: - Body

extension GlobalEntity.Plate {

    public static let settingsPlate: SettingsPlateInterface = SettingsPlate(
        isBackgroundMusicOn: false,
        backgroundMusicVolume: 0,
        isSoundEffectOn: false,
        soundEffectVolume: 0,
        isHapticFeedbackOn: false
    )
}

public protocol SettingsPlateInterface: GlobalEntity.Plate.Interface, Sendable {

    // MARK: - Get

    func getIsBackgroundMusicOn() async -> Bool
    func getBackgroundMusicVolume() async -> Double
    func getIsSoundEffectOn() async -> Bool
    func getSoundEffectVolume() async -> Double
    func getIsHapticFeedbackOn() async -> Bool



    // MARK: - Set

    func setIsBackgroundMusicOn(_ isBackgroundMusicOn: Bool) async
    func setBackgroundMusicVolume(_ backgroundMusicVolume: Double) async
    func setIsSoundEffectOn(_ isSoundEffectOn: Bool) async
    func setSoundEffectVolume(_ soundEffectVolume: Double) async
    func setIsHapticFeedbackOn(_ isHapticFeedbackOn: Bool) async

    // MARK: - Else

    func reset() async
}

fileprivate final actor SettingsPlate: SettingsPlateInterface {

    // MARK: - GlobalEntity/Plate/Interface

    nonisolated let designation: PlateDesignation = .settings

    // MARK: - SettingsPlateInterface

    // MARK: - Get

    func getIsBackgroundMusicOn() async -> Bool {
        isBackgroundMusicOn
    }

    func getBackgroundMusicVolume() async -> Double {
        backgroundMusicVolume
    }

    func getIsSoundEffectOn() async -> Bool {
        isSoundEffectOn
    }

    func getSoundEffectVolume() async -> Double {
        soundEffectVolume
    }

    func getIsHapticFeedbackOn() async -> Bool {
        isHapticFeedbackOn
    }


    // MARK: - Set

    func setIsBackgroundMusicOn(_ isBackgroundMusicOn: Bool) async {
        self.isBackgroundMusicOn = isBackgroundMusicOn
        await updateViewModel()
    }

    func setBackgroundMusicVolume(_ backgroundMusicVolume: Double) async {
        self.backgroundMusicVolume = backgroundMusicVolume
        await updateViewModel()
    }

    func setIsSoundEffectOn(_ isSoundEffectOn: Bool) async {
        self.isSoundEffectOn = isSoundEffectOn
        await updateViewModel()
    }

    func setSoundEffectVolume(_ soundEffectVolume: Double) async {
        self.soundEffectVolume = soundEffectVolume
        await updateViewModel()
    }

    func setIsHapticFeedbackOn(_ isHapticFeedbackOn: Bool) async {
        self.isHapticFeedbackOn = isHapticFeedbackOn
        await updateViewModel()
    }

    // MARK: - Else

    func reset() async {
        isBackgroundMusicOn = false
        backgroundMusicVolume = 0
        isSoundEffectOn = false
        soundEffectVolume = 0
        isHapticFeedbackOn = false
        await updateViewModel()
    }

    private func updateViewModel() async {
        let capturedIsBackgroundMusicOn = isBackgroundMusicOn
        let capturedBackgroundMusicVolume = backgroundMusicVolume
        let capturedIsSoundEffectOn = isSoundEffectOn
        let capturedSoundEffectVolume = soundEffectVolume
        let capturedIsHapticFeedbackOn = isHapticFeedbackOn
        await MainActor.run {
            viewModel.backgroundMusicToggleValue = capturedIsBackgroundMusicOn
            viewModel.isBackgroundMusicVolumeSliderAvailable = capturedIsBackgroundMusicOn
            viewModel.backgroundMusicVolumeSliderValue = capturedBackgroundMusicVolume
            viewModel.soundEffectToggleValue = capturedIsSoundEffectOn
            viewModel.isSoundEffectVolumeSliderAvailable = capturedIsSoundEffectOn
            viewModel.soundEffectVolumeSliderValue = capturedSoundEffectVolume
            viewModel.hapticFeedbackToggleValue = capturedIsHapticFeedbackOn
        }
    }

    // MARK: - Holding Property

    private var isBackgroundMusicOn: Bool
    private var backgroundMusicVolume: Double
    private var isSoundEffectOn: Bool
    private var soundEffectVolume: Double
    private var isHapticFeedbackOn: Bool

    // MARK: - Lifecycle

    init(
        isBackgroundMusicOn: Bool,
        backgroundMusicVolume: Double,
        isSoundEffectOn: Bool,
        soundEffectVolume: Double,
        isHapticFeedbackOn: Bool
    ) {
        self.isBackgroundMusicOn = isBackgroundMusicOn
        self.backgroundMusicVolume = backgroundMusicVolume
        self.isSoundEffectOn = isSoundEffectOn
        self.soundEffectVolume = soundEffectVolume
        self.isHapticFeedbackOn = isHapticFeedbackOn
    }
}
