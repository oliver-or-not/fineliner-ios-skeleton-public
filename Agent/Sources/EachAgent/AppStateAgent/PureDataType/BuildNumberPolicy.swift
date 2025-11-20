// MARK: - Module Dependency

import SwiftUI

// MARK: - Body

/// 빌드 번호 정책. 강제 업데이트 등.
public struct BuildNumberPolicy: Codable, Sendable {

    /// 이 값보다 빌드 번호가 낮으면 강제 업데이트 대상이다.
    public var minimumSupportedBuildNumber: Int
    /// 이 값보다 빌드 번호가 낮으면 업데이트 권유 대상이다.
    public var minimumRecommendedBuildNumber: Int

    public init(minimumSupportedBuildNumber: Int, minimumRecommendedBuildNumber: Int) {
        self.minimumSupportedBuildNumber = minimumSupportedBuildNumber
        self.minimumRecommendedBuildNumber = minimumRecommendedBuildNumber
    }
}
