// MARK: - Module Dependency

import SwiftUI
import GoogleMobileAds
import Spectrum
import Director
import Agent
import PlateBase

// MARK: - Context

@MainActor fileprivate let primeEventDirector = GlobalEntity.Director.primeEvent

// MARK: - Body

public struct MainPlateView: View {

    // MARK: - Holding Property

    @Bindable private var viewModel: MainPlateViewModel
    @State private var titleScaleEffectTrigger: Bool = false

    // MARK: - Lifecycle

    public init(viewModel: MainPlateViewModel = .shared) {
        self.viewModel = viewModel
    }

    // MARK: - Layout

    public var body: some View {
        ZStack {
            DS.PaletteColor.white
            VStack(spacing: 0) {
                Spacer().frame(height: 80)
                titleSection
                Spacer().frame(height: 60)
                gameStartButton
                    .padding()
                settingsButton
                    .padding()
            }
            if viewModel.isBannerAdShown,
               let bannerAdUnitId = viewModel.bannerAdUnitId {
                VStack(spacing: 0) {
                    Spacer()
                    MainPlateBannerAdView(unitId: bannerAdUnitId)
                }
                .safeAreaPadding(.bottom)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            titleScaleEffectTrigger = true
        }
    }

    private var titleSection: some View {
        Text("Skeleton_temp")
            .foregroundStyle(.black)
    }

    private var gameStartButton: some View {
        Button {
            Task {
                await primeEventDirector.receive(.mainPlateGameStartButtonTapped)
            }
        } label: {
            Text(String(lKey: .mainPlatePlayButtonTitle))
                .foregroundStyle(.black)
        }
    }

    private var settingsButton: some View {
        Button {
            Task {
                await primeEventDirector.receive(.mainPlateSettingsButtonTapped)
            }
        } label: {
            Text(String(lKey: .mainPlateSettingsButtonTitle))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    MainPlateView(viewModel: MainPlateViewModel(
        bannerAdUnitId: nil,
        isBannerAdShown: false
    ))
}

