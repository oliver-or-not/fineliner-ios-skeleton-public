// MARK: - Module Dependency

import SwiftUI
import UIKit
import Combine
import Spectrum
import Director
import Agent

// MARK: - Context

@MainActor fileprivate let primeEventDirector = GlobalEntity.Director.primeEvent

// MARK: - Body

public struct BasicGamePlateView: View {

    @Bindable private var viewModel: BasicGamePlateViewModel

    // MARK: - Lifecycle

    public init(viewModel: BasicGamePlateViewModel = .shared) {
        self.viewModel = viewModel
    }

    // MARK: - Layout

    public var body: some View {
        ZStack {
            DS.PaletteColor.blue
            Button(action: {
                Task { @MainActor in
                    await primeEventDirector.receive(.basicGamePlateBackButtonTapped)
                }
            }, label: {
                Text("Back_temp")
            })
        }
    }
}
