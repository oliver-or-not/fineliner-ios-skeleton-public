// MARK: - Module Dependency

import UIKit
import Universe
import Spectrum
import Director
import AgentBase

// MARK: - Context

fileprivate let logDirector = GlobalEntity.Director.log

// MARK: - Body

extension GlobalEntity.Agent {

    public static let appInfoAgent: AppInfoAgentInterface = AppInfoAgent(
        activationLevel: .inactive
    )
}

public protocol AppInfoAgentInterface: GlobalEntity.Agent.Interface, Sendable {

    func getBuildNumber() async -> Int

    func getBundleId() async -> String

    func getSupabaseUrlString() async -> String

    func getSupabaseKey() async -> String

    func getCustomGoogleAdUnitIdForMainPlateBottomBannerAd() async -> String

    func getCustomGoogleAdUnitIdForResultDialogFullAd() async -> String
}

fileprivate final actor AppInfoAgent: AppInfoAgentInterface {

    // MARK: - GlobalEntity/Agent/Interface

    nonisolated let designation: AgentDesignation = .appInfo

    var activationLevel: GlobalEntity.Agent.ActivationLevel

    func setActivationLevel(_ activationLevel: GlobalEntity.Agent.ActivationLevel) async {
        self.activationLevel = activationLevel
    }

    // MARK: - AppInfoAgentInterface

    func getBuildNumber() async -> Int {
        let buildNumberString = infoDictionary[AppInfoKey.cfBundleVersion.rawValue] as? String
        let safeBuildNumberString = buildNumberString ?? "0"
        if let buildNumber = Int(safeBuildNumberString) {
            return buildNumber
        } else {
            await logDirector.agentLog(
                .appInfo,
                .error,
                "Build number is not an integer: \(safeBuildNumberString); Returns 0 instead."
            )
            return 0
        }
    }

    func getBundleId() async -> String {
        let bundleIdString = infoDictionary[AppInfoKey.cfBundleIdentifier.rawValue] as? String
        if let bundleIdString {
            return bundleIdString
        } else {
            await logDirector.agentLog(
                .appInfo,
                .error,
                "Bundle Id is missing; Returns empty string instead."
            )
            return ""
        }
    }

    func getSupabaseUrlString() async -> String {
        let supabaseUrlString = infoDictionary[AppInfoKey.customSupabaseUrlString.rawValue] as? String
        if let supabaseUrlString {
            return supabaseUrlString
        } else {
            await logDirector.agentLog(
                .appInfo,
                .error,
                "Supabase URL string is missing; Returns empty string instead."
            )
            return ""
        }
    }

    func getSupabaseKey() async -> String {
        let supabaseKey = infoDictionary[AppInfoKey.customSupabaseKey.rawValue] as? String
        if let supabaseKey {
            return supabaseKey
        } else {
            await logDirector.agentLog(
                .appInfo,
                .error,
                "Supabase key is missing; Returns empty string instead."
            )
            return ""
        }
    }

    func getCustomGoogleAdUnitIdForMainPlateBottomBannerAd() async -> String {
        let adUnitId = infoDictionary[AppInfoKey.customGoogleAdUnitIdForMainPlateBottomBannerAd.rawValue] as? String
        if let adUnitId {
            return adUnitId
        } else {
            await logDirector.agentLog(
                .appInfo,
                .error,
                "customGoogleAdUnitIdForMainPlateBottomBannerAd is missing; Returns empty string instead."
            )
            return ""
        }
    }

    func getCustomGoogleAdUnitIdForResultDialogFullAd() async -> String {
        let adUnitId = infoDictionary[AppInfoKey.customGoogleAdUnitIdForResultDialogFullAd.rawValue] as? String
        if let adUnitId {
            return adUnitId
        } else {
            await logDirector.agentLog(
                .appInfo,
                .error,
                "customGoogleAdUnitIdForResultDialogFullAd is missing; Returns empty string instead."
            )
            return ""
        }
    }

    // MARK: - Holding Property

    private let infoDictionary = Bundle.main.infoDictionary!

    // MARK: - Lifecycle

    init(
        activationLevel: GlobalEntity.Agent.ActivationLevel
    ) {
        self.activationLevel = activationLevel
    }

    // MARK: - Key

    enum AppInfoKey: String {

        case cfBundleVersion = "CFBundleVersion"
        case cfBundleIdentifier = "CFBundleIdentifier"
        case customSupabaseUrlString = "CUSTOM_SUPABASE_URL_STRING"
        case customSupabaseKey = "CUSTOM_SUPABASE_KEY"
        case customGoogleAdUnitIdForMainPlateBottomBannerAd = "CUSTOM_GOOGLE_AD_UNIT_ID_FOR_MAIN_PLATE_BOTTOM_BANNER_AD"
        case customGoogleAdUnitIdForResultDialogFullAd = "CUSTOM_GOOGLE_AD_UNIT_ID_FOR_RESULT_DIALOG_FULL_AD"
    }
}
