// MARK: - Module Dependency

import SwiftUI
import Spectrum
import AgentBase

// MARK: - Body

extension GlobalEntity.Agent {

    public static let appStateAgent: AppStateAgentInterface = AppStateAgent(
        activationLevel: .inactive
    )
}

public protocol AppStateAgentInterface: GlobalEntity.Agent.Interface, Sendable {

    /// 마이그레이션이 완료된 빌드 번호.
    func getMigratedBuildNumber() async -> Int?
    /// 마이그레이션이 완료된 빌드 번호.
    func setMigratedBuildNumber(_ value: Int?) async

    /// 빌드 번호 정책을 서버에서 마지막으로 받아온 시각.
    func getLastFetchedDateOfBuildNumberPolicy() async -> Date?
    /// 빌드 번호 정책을 서버에서 마지막으로 받아온 시각.
    func setLastFetchedDateOfBuildNumberPolicy(_ value: Date?) async

    /// 빌드 번호 정책. 강제 업데이트 등.
    func getBuildNumberPolicy() async -> BuildNumberPolicy?
    /// 빌드 번호 정책. 강제 업데이트 등.
    func setBuildNumberPolicy(_ value: BuildNumberPolicy?) async

    /// 인스톨 id. 유저 식별자 역할을 한다.
    func getInstallId() async -> String
    /// 인스톨 id. 유저 식별자 역할을 한다.
    func setInstallId(_ value: String) async

    /// 배경음악 on/off.
    func getIsBackgroundMusicOn() async -> Bool
    /// 배경음악 on/off.
    func setIsBackgroundMusicOn(_ value: Bool) async

    /// 배경음악 볼륨.
    func getBackgroundMusicVolume() async -> Double
    /// 배경음악 볼륨.
    func setBackgroundMusicVolume(_ value: Double) async

    /// 효과음 on/off.
    func getIsSoundEffectOn() async -> Bool
    /// 효과음 on/off.
    func setIsSoundEffectOn(_ value: Bool) async

    /// 효과음 볼륨.
    func getSoundEffectVolume() async -> Double
    /// 효과음 볼륨.
    func setSoundEffectVolume(_ value: Double) async

    /// 햅틱 피드백 on/off.
    func getIsHapticFeedbackOn() async -> Bool
    /// 햅틱 피드백 on/off.
    func setIsHapticFeedbackOn(_ value: Bool) async

    /// 게임이 끝난 후의 전면 광고가 보여진 횟수. 종종 초기화된다.
    func getBasicGameFinishDialogFullAdCount() async -> Int
    /// 게임이 끝난 후의 전면 광고가 보여진 횟수. 종종 초기화된다.
    func setBasicGameFinishDialogFullAdCount(_ value: Int) async

    /// 게임이 끝난 후의 전면 광고가 보여진 횟수가 마지막으로 더해진 시각.
    func getLastAddedDateOfBasicGameFinishDialogFullAdCount() async -> Date?
    /// 게임이 끝난 후의 전면 광고가 보여진 횟수가 마지막으로 더해진 시각.
    func setLastAddedDateOfBasicGameFinishDialogFullAdCount(_ value: Date?) async

    /// 게임이 마지막으로 끝난 시각.
    func getLastFinishedDateOfBasicGame() async -> Date?
    /// 게임이 마지막으로 끝난 시각.
    func setLastFinishedDateOfBasicGame(_ value: Date?) async

    /// 게임이 끝난 후의 전면 광고를 마지막으로 로드한 시각.
    func getLastLoadedDateOfBasicGameFinishDialogFullAd() async -> Date?
    /// 게임이 끝난 후의 전면 광고를 마지막으로 로드한 시각.
    func setLastLoadedDateOfBasicGameFinishDialogFullAd(_ value: Date?) async
}

fileprivate final actor AppStateAgent: AppStateAgentInterface {

    // MARK: - GlobalEntity/Agent/Interface

    nonisolated let designation: AgentDesignation = .appState

    var activationLevel: GlobalEntity.Agent.ActivationLevel

    func setActivationLevel(_ activationLevel: GlobalEntity.Agent.ActivationLevel) async {
        self.activationLevel = activationLevel
    }

    // MARK: - Holding Property - Hidden

    private let storageWorker = AppStateAgentStorageWorker()

    // MARK: - AppStateAgentInterface

    func getMigratedBuildNumber() async -> Int? {
        await migratedBuildNumber.get()
    }
    func setMigratedBuildNumber(_ value: Int?) async {
        await migratedBuildNumber.set(value)
    }

    func getLastFetchedDateOfBuildNumberPolicy() async -> Date? {
        await lastFetchedDateOfBuildNumberPolicy.get()
    }
    func setLastFetchedDateOfBuildNumberPolicy(_ value: Date?) async {
        await lastFetchedDateOfBuildNumberPolicy.set(value)
    }

    func getBuildNumberPolicy() async -> BuildNumberPolicy? {
        await buildNumberPolicy.get()
    }
    func setBuildNumberPolicy(_ value: BuildNumberPolicy?) async {
        await buildNumberPolicy.set(value)
    }

    func getInstallId() async -> String {
        await installId.get()
    }
    func setInstallId(_ value: String) async {
        await installId.set(value)
    }

    func getIsBackgroundMusicOn() async -> Bool {
        await isBackgroundMusicOn.get()
    }
    func setIsBackgroundMusicOn(_ value: Bool) async {
        await isBackgroundMusicOn.set(value)
    }

    func getBackgroundMusicVolume() async -> Double {
        await backgroundMusicVolume.get()
    }
    func setBackgroundMusicVolume(_ value: Double) async {
        await backgroundMusicVolume.set(value)
    }

    func getIsSoundEffectOn() async -> Bool {
        await isSoundEffectOn.get()
    }
    func setIsSoundEffectOn(_ value: Bool) async {
        await isSoundEffectOn.set(value)
    }

    func getSoundEffectVolume() async -> Double {
        await soundEffectVolume.get()
    }
    func setSoundEffectVolume(_ value: Double) async {
        await soundEffectVolume.set(value)
    }

    func getIsHapticFeedbackOn() async -> Bool {
        await isHapticFeedbackOn.get()
    }
    func setIsHapticFeedbackOn(_ value: Bool) async {
        await isHapticFeedbackOn.set(value)
    }

    func getBasicGameFinishDialogFullAdCount() async -> Int {
        await basicGameFinishDialogFullAdCount.get()
    }
    func setBasicGameFinishDialogFullAdCount(_ value: Int) async {
        await basicGameFinishDialogFullAdCount.set(value)
    }

    func getLastAddedDateOfBasicGameFinishDialogFullAdCount() async -> Date? {
        await lastAddedDateOfBasicGameFinishDialogFullAdCount.get()
    }
    func setLastAddedDateOfBasicGameFinishDialogFullAdCount(_ value: Date?) async {
        await lastAddedDateOfBasicGameFinishDialogFullAdCount.set(value)
    }

    func getLastFinishedDateOfBasicGame() async -> Date? {
        await lastFinishedDateOfBasicGame.get()
    }
    func setLastFinishedDateOfBasicGame(_ value: Date?) async {
        await lastFinishedDateOfBasicGame.set(value)
    }

    func getLastLoadedDateOfBasicGameFinishDialogFullAd() async -> Date? {
        await lastLoadedDateOfBasicGameFinishDialogFullAd.get()
    }
    func setLastLoadedDateOfBasicGameFinishDialogFullAd(_ value: Date?) async {
        await lastLoadedDateOfBasicGameFinishDialogFullAd.set(value)
    }

    // MARK: - Holding Property

    /// 마이그레이션이 완료된 빌드 번호.
    private lazy var migratedBuildNumber: AppStateAgentStorableItem<Int, Int?> = .init(
        storageKey: .migratedBuildNumber,
        storageToRamTypeCastingClosure: { $0 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 최소 지원 버전을 서버로부터 마지막으로 받아온 시각.
    private lazy var lastFetchedDateOfBuildNumberPolicy: AppStateAgentStorableItem<Date, Date?> = .init(
        storageKey: .lastFetchedDateOfBuildNumberPolicy,
        storageToRamTypeCastingClosure: { $0 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 빌드 번호 정책. 강제 업데이트 등.
    private lazy var buildNumberPolicy: AppStateAgentStorableItem<BuildNumberPolicy, BuildNumberPolicy?> = .init(
        storageKey: .buildNumberPolicy,
        storageToRamTypeCastingClosure: { $0 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 인스톨 id. 유저 식별자 역할을 한다.
    private lazy var installId: AppStateAgentStorableItem<String, String> = .init(
        storageKey: .installId,
        storageToRamTypeCastingClosure: { stored in stored ?? UUID().uuidString },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 배경음악 on/off.
    private lazy var isBackgroundMusicOn: AppStateAgentStorableItem<Bool, Bool> = .init(
        storageKey: .isBackgroundMusicOn,
        storageToRamTypeCastingClosure: { stored in stored ?? true },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 배경음악 볼륨.
    private lazy var backgroundMusicVolume: AppStateAgentStorableItem<Double, Double> = .init(
        storageKey: .backgroundMusicVolume,
        storageToRamTypeCastingClosure: { stored in stored ?? 0.5 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 효과음 on/off.
    private lazy var isSoundEffectOn: AppStateAgentStorableItem<Bool, Bool> = .init(
        storageKey: .isSoundEffectOn,
        storageToRamTypeCastingClosure: { stored in stored ?? true },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 효과음 볼륨.
    private lazy var soundEffectVolume: AppStateAgentStorableItem<Double, Double> = .init(
        storageKey: .soundEffectVolume,
        storageToRamTypeCastingClosure: { stored in stored ?? 0.5 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 햅틱 피드백 on/off.
    private lazy var isHapticFeedbackOn: AppStateAgentStorableItem<Bool, Bool> = .init(
        storageKey: .isHapticFeedbackOn,
        storageToRamTypeCastingClosure: { stored in stored ?? true },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 게임이 끝난 후의 전면 광고가 보여진 횟수. 종종 초기화된다.
    private lazy var basicGameFinishDialogFullAdCount: AppStateAgentStorableItem<Int, Int> = .init(
        storageKey: .basicGameFinishDialogFullAdCount,
        storageToRamTypeCastingClosure: { stored in stored ?? 0 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 게임이 끝난 후의 전면 광고가 보여진 횟수가 마지막으로 더해진 시각.
    private lazy var lastAddedDateOfBasicGameFinishDialogFullAdCount: AppStateAgentStorableItem<Date, Date?> = .init(
        storageKey: .lastAddedDateOfBasicGameFinishDialogFullAdCount,
        storageToRamTypeCastingClosure: { $0 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 게임이 마지막으로 끝난 시각.
    private lazy var lastFinishedDateOfBasicGame: AppStateAgentStorableItem<Date, Date?> = .init(
        storageKey: .lastFinishedDateOfBasicGame,
        storageToRamTypeCastingClosure: { $0 },
        ramToStorageTypeCastingClosure: { $0 },
        storageWorker: storageWorker
    )
    /// 게임이 끝난 후의 전면 광고를 마지막으로 로드한 시각.
    private lazy var lastLoadedDateOfBasicGameFinishDialogFullAd: AppStateAgentVolatileItem<Date?> = .init(
        value: nil
    )

    // MARK: - Lifecycle

    init(
        activationLevel: GlobalEntity.Agent.ActivationLevel
    ) {
        self.activationLevel = activationLevel
    }
}
