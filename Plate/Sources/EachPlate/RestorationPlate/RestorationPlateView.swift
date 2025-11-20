// MARK: - Module Dependency

import SwiftUI
import Spectrum
import Director
import PlateBase

// MARK: - Context

@MainActor fileprivate let primeEventDirector = GlobalEntity.Director.primeEvent

// MARK: - Body

public struct RestorationPlateView: View {

    @Bindable private var viewModel: RestorationPlateViewModel

    public var body: some View {
        ZStack {
            DS.PaletteColor.white
            DSCircularLoadingView(color: DS.PaletteColor.black.opacity(0.3))
            forceUpdateDialog
            updateRecommendationDialog
        }
    }

    public init(viewModel: RestorationPlateViewModel = .shared) {
        self.viewModel = viewModel
    }

    private var forceUpdateDialog: some View {
        let isShown = viewModel.isForceUpdateDialogShown
        return ZStack {
            DS.SemanticColor.dim
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 30)
                Text(String(lKey: .restorationPlateForceUpdateDialogMessage))
                    .font(.system(size: 17))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.2)
                    .padding()
                Spacer()
                    .frame(height: 30)
                Button {
                    Task {
                        await primeEventDirector.receive(
                            .restorationPlateForceUpdateDialogOkButtonTapped
                        )
                    }
                } label: {
                    Text(String(lKey: .restorationPlateForceUpdateDialogOkButtonTitle))
                        .font(.system(size: 17))
                        .foregroundStyle(.black)
                        .frame(width: 80)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .buttonBorderShape(.capsule)
                .tint(DS.SemanticColor.dialogButtonBackground)
                .buttonStyle(.borderedProminent)
                Spacer()
                    .frame(height: 30)
            }
            .frame(width: 280)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(DS.SemanticColor.dialogBackground)
            )
            .scaleEffect(isShown ? 1 : 0.9)
        }
        .opacity(isShown ? 1 : 0)
        .allowsHitTesting(isShown)
        .animation(.smooth(duration: .init(seconds: 0.5)), value: isShown)
    }

    private var updateRecommendationDialog: some View {
        let isShown = viewModel.isUpdateRecommendationDialogShown
        return ZStack {
            DS.SemanticColor.dim
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 30)
                Text(String(lKey: .restorationPlateUpdateRecommendationDialogMessage))
                    .font(.system(size: 17))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.2)
                    .padding()
                Spacer()
                    .frame(height: 30)
                HStack(spacing: 0) {
                    Button {
                        Task {
                            await primeEventDirector.receive(
                                .restorationPlateUpdateRecommendationDialogLaterButtonTapped
                            )
                        }
                    } label: {
                        Text(String(lKey: .restorationPlateUpdateRecommendationDialogCancelButtonTitle))
                            .font(.system(size: 17))
                            .foregroundStyle(.black)
                            .frame(width: 80)
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                    }
                    .buttonBorderShape(.capsule)
                    .tint(DS.SemanticColor.dialogButtonBackground)
                    .buttonStyle(.borderedProminent)
                    Spacer()
                        .frame(width: 15)
                    Button {
                        Task {
                            await primeEventDirector.receive(
                                .restorationPlateUpdateRecommendationDialogUpdateButtonTapped
                            )
                        }
                    } label: {
                        Text(String(lKey: .restorationPlateUpdateRecommendationDialogOkButtonTitle))
                            .font(.system(size: 17))
                            .foregroundStyle(.black)
                            .frame(width: 80)
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                    }
                    .buttonBorderShape(.capsule)
                    .tint(DS.SemanticColor.dialogButtonBackground)
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
                    .frame(height: 30)
            }
            .frame(width: 280)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(DS.SemanticColor.dialogBackground)
            )
            .scaleEffect(isShown ? 1 : 0.9)
        }
        .opacity(isShown ? 1 : 0)
        .allowsHitTesting(isShown)
        .animation(.smooth(duration: .init(seconds: 0.5)), value: isShown)
    }
}
