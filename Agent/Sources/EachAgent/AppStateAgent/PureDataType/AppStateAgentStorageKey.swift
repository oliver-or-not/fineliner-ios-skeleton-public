// MARK: - Body

public enum AppStateAgentStorageKey: String, Sendable {

    case migratedBuildNumber = "migrated-build-number"
    case lastFetchedDateOfBuildNumberPolicy = "last-fetched-date-of-build-number-policy"
    case buildNumberPolicy = "build-number-policy"
    case installId = "install-id"
    case isBackgroundMusicOn = "is-background-music-on"
    case backgroundMusicVolume = "background-music-volume"
    case isSoundEffectOn = "is-sound-effect-on"
    case soundEffectVolume = "sound-effect-volume"
    case isHapticFeedbackOn = "is-haptic-feedback-on"
    case basicGameFinishDialogFullAdCount = "basic-game-finish-dialog-full-ad-count"
    case lastAddedDateOfBasicGameFinishDialogFullAdCount = "last-added-date-of-basic-game-finish-dialog-full-ad-count"
    case lastFinishedDateOfBasicGame = "last-finished-date-of-basic-game"
}
