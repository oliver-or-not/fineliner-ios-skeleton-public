// MARK: - Module Dependency

import Foundation
@preconcurrency import Supabase
import Universe
import Spectrum
import AgentBase

// MARK: - Body

extension GlobalEntity.Agent {

    public static let networkAgent: NetworkAgentInterface = NetworkAgent(
        activationLevel: .inactive
    )
}

public protocol NetworkAgentInterface: GlobalEntity.Agent.Interface, Sendable {

    func initSupabaseClient(supabaseUrl: URL, supabaseKey: String) async

    func fetchBuildNumberPolicy() async throws -> BuildNumberPolicy
}

fileprivate final actor NetworkAgent: NetworkAgentInterface {

    // MARK: - GlobalEntity/Agent/Interface

    let designation: AgentDesignation = .network

    var activationLevel: GlobalEntity.Agent.ActivationLevel

    func setActivationLevel(_ activationLevel: GlobalEntity.Agent.ActivationLevel) async {
        self.activationLevel = activationLevel
    }

    // MARK: - NetworkAgentInterface

    func initSupabaseClient(supabaseUrl: URL, supabaseKey: String) async {
//        supabase = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseKey)
    }

    func fetchBuildNumberPolicy() async throws -> BuildNumberPolicy {
        return BuildNumberPolicy(
            minimumSupportedBuildNumber: 0,
            minimumRecommendedBuildNumber: 0
        )
    }

    // MARK: - Holding Property

    var supabase: SupabaseClient?

    // MARK: - Lifecycle

    init(
        activationLevel: GlobalEntity.Agent.ActivationLevel
    ) {
        self.activationLevel = activationLevel
    }
}
