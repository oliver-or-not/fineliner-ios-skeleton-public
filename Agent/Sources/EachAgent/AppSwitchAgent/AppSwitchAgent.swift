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

    public static let appSwitchAgent: AppSwitchAgentInterface = AppSwitchAgent(
        activationLevel: .inactive
    )
}

public protocol AppSwitchAgentInterface: GlobalEntity.Agent.Interface, Sendable {

    func switchTo(_ key: AppSwitchKey) async throws
}

fileprivate final actor AppSwitchAgent: AppSwitchAgentInterface {

    // MARK: - GlobalEntity/Agent/Interface

    let designation: AgentDesignation = .appSwitch

    var activationLevel: GlobalEntity.Agent.ActivationLevel

    func setActivationLevel(_ activationLevel: GlobalEntity.Agent.ActivationLevel) async {
        self.activationLevel = activationLevel
    }

    // MARK: - AppSwitchAgentInterface

    func switchTo(_ key: AppSwitchKey) async throws {
        let url: URL?
        switch key {
        case .appStorePageOfThisApp:
            url = URL(string: "itms-apps://apps.apple.com/app/id-xxx-skeleton")
        }
        if let url {
            await MainActor.run {
                UIApplication.shared.open(
                    url,
                    options: [:],
                    completionHandler: nil
                )
            }
        } else {
            await logDirector.agentLog(
                .appSwitch,
                .error,
                "URL for key `\(key)` is not found."
            )
        }
    }

    // MARK: - Lifecycle

    init(
        activationLevel: GlobalEntity.Agent.ActivationLevel
    ) {
        self.activationLevel = activationLevel
    }
}
