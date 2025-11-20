// MARK: - Module Dependency

import UIKit
@preconcurrency import GoogleMobileAds
import Universe
import Spectrum
import Director
import AgentBase

// MARK: - Context

fileprivate let logDirector = GlobalEntity.Director.log

// MARK: - Body

extension GlobalEntity.Agent {

    public static let googleAdAgent: GoogleAdAgentInterface = GoogleAdAgent(
        activationLevel: .inactive,
        isFullAdConsumed: false
    )
}

public protocol GoogleAdAgentInterface: GlobalEntity.Agent.Interface, Sendable {

    func start() async

    /// start() 호출 후에 호출해야 한다.
    func loadFullAd(fullAdUnitId: String) async

    func getIsFullAdConsumed() async -> Bool

    /// loadFullAd(fullAdUnitId:) 호출 후에 호출해야 한다.
    func showFullAd() async
}

fileprivate final actor GoogleAdAgent: NSObject, FullScreenContentDelegate, GoogleAdAgentInterface {

    // MARK: - GlobalEntity/Agent/Interface

    let designation: AgentDesignation = .googleAd

    var activationLevel: GlobalEntity.Agent.ActivationLevel

    func setActivationLevel(_ activationLevel: GlobalEntity.Agent.ActivationLevel) async {
        self.activationLevel = activationLevel
    }

    // MARK: - GoogleAdAgentInterface

    func start() async {
//        await MobileAds.shared.start()
    }

    func loadFullAd(fullAdUnitId: String) async {
//        do {
//            fullAd = try await InterstitialAd.load(with: fullAdUnitId, request: Request())
//            isFullAdConsumed = false
//        } catch {
//            await logDirector.agentLog(
//                .googleAd,
//                .error,
//                "Failed to load interstitial ad. error: : \(error)"
//            )
//        }
    }

    func getIsFullAdConsumed() async -> Bool {
        isFullAdConsumed
    }

    func showFullAd() async {
        isFullAdConsumed = true
//        if let fullAd {
//            fullAd.fullScreenContentDelegate = self
//            await fullAd.present(from: nil)
//        }
    }

    // MARK: - Holding Property

    private var fullAd: InterstitialAd?
    private var isFullAdConsumed: Bool

    // MARK: - Lifecycle

    init(
        activationLevel: GlobalEntity.Agent.ActivationLevel,
        isFullAdConsumed: Bool
    ) {
        self.activationLevel = activationLevel
        self.isFullAdConsumed = isFullAdConsumed
    }
}
