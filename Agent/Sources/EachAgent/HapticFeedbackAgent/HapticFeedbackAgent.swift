// MARK: - Module Dependency

import UIKit
import Universe
import Spectrum
import AgentBase

// MARK: - Body

extension GlobalEntity.Agent {

    @MainActor public static let hapticFeedbackAgent: HapticFeedbackAgentInterface = HapticFeedbackAgent(
        activationLevel: .inactive
    )
}

public protocol HapticFeedbackAgentInterface: GlobalEntity.Agent.Interface, Sendable {

    func neutralFeedback() async

    func warningFeedback() async
}

@MainActor fileprivate final class HapticFeedbackAgent: HapticFeedbackAgentInterface {

    // MARK: - GlobalEntity/Agent/Interface

    let designation: AgentDesignation = .hapticFeedback

    var activationLevel: GlobalEntity.Agent.ActivationLevel

    func setActivationLevel(_ activationLevel: GlobalEntity.Agent.ActivationLevel) async {
        self.activationLevel = activationLevel
    }

    // MARK: - HapticFeedbackAgentInterface

    func neutralFeedback() async {
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred(intensity: 1.0)
    }

    func warningFeedback() async {
        notificationFeedbackGenerator.prepare()
        notificationFeedbackGenerator.notificationOccurred(.error)
    }

    // MARK: - Holding Property

    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    // MARK: - Lifecycle

    init(
        activationLevel: GlobalEntity.Agent.ActivationLevel
    ) {
        self.activationLevel = activationLevel
    }
}
