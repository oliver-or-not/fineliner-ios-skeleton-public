// MARK: - Body

public enum AgentDesignation: String, Sendable, CaseIterable {

    // MARK: - Remote Data Source

    /// 통신.
    case network
    /// 시각.
    case date

    // MARK: - App

    /// 영구 저장소 및 앱의 전역적인 상태 정보.
    case appState
    /// 빌드 번호 등 앱의 정보.
    case appInfo

    // MARK: - OS Feature

    /// 애플 광고 식별자.
    case idfa

    // MARK: - Thirdparty Feature

    /// 구글 광고.
    case googleAd

    // MARK: - Output

    /// 플레이트의 스택.
    case plateStack
    /// 소리.
    case sound
    /// 햅틱 피드백.
    case hapticFeedback
    /// 앱 이동.
    case appSwitch
}
