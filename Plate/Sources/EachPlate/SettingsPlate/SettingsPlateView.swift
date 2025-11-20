// MARK: - Module Dependency

import SwiftUI
import Spectrum
import Director
import Agent
import PlateBase

// MARK: - Context

@MainActor fileprivate let primeEventDirector = GlobalEntity.Director.primeEvent
fileprivate typealias Constant = SettingsPlateConstant

// MARK: - Body

public struct SettingsPlateView: View {

    // MARK: - Holding Property

    @Bindable private var viewModel: SettingsPlateViewModel

    // MARK: - Lifecycle

    public init(viewModel: SettingsPlateViewModel = .shared) {
        self.viewModel = viewModel
    }

    // MARK: - Layout

    public var body: some View {
        ZStack {
            DS.PaletteColor.green
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    Spacer().frame(height: 80)
                    titleSection
                        .padding([.horizontal, .bottom])
                    Spacer().frame(height: 20)
                    backgroundMusicSection
                        .padding([.horizontal, .bottom])
                    soundEffectSection
                        .padding([.horizontal, .bottom])
                    hapticFeedbackSection
                        .padding([.horizontal])
                    Spacer().frame(height: 400)
                }
            }
            VStack(spacing: 0) {
                Spacer().frame(height: 40)
                topAppBar
                Spacer()
            }
        }
    }

    private var topAppBar: some View {
        ZStack {
            HStack {
                Spacer().frame(minWidth: 16)
                Button {
                    Task {
                        await primeEventDirector.receive(.settingsPlateCloseButtonTapped)
                    }
                } label: {
                    DS.SymbolImage.xmark
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.black)
                        .padding(4)
                        .contentShape(Circle())
                        .background(Circle().fill(DS.SemanticColor.interactable))
                }
                Spacer().frame(width: 16)
            }
        }
    }

    private var titleSection: some View {
        HStack {
            Text(String(lKey: .settingsPlateTitle))
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
            Spacer()
        }
    }

    private var backgroundMusicSection: some View {
        ZStack {
            Spacer().frame(idealWidth: .infinity)
            VStack(alignment: .center, spacing: 0) {
                Toggle(isOn: Binding(
                    get: { viewModel.backgroundMusicToggleValue },
                    set: { _, _ in
                        Task {
                            await primeEventDirector.receive(.settingsPlateBackgroundMusicToggleTapped)
                        }
                    }
                ), label: {
                    Text(String(lKey: .settingsPlateBackgroundMusicSectionTitle))
                        .font(.system(size: 22))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                })
                .tint(DS.SemanticColor.interactableVivid)
                Spacer().frame(height: 15)
                Slider(
                    value: Binding(
                        get: {
                            min(max(0, viewModel.backgroundMusicVolumeSliderValue), 1)
                        },
                        set: { newValue, transaction in
                            Task {
                                await primeEventDirector.receive(.settingsPlateBackgroundMusicSlideSet(value: newValue))
                            }
                        }
                    ),
                    in: Constant.backgroundMusicSliderRange,
                    onEditingChanged: { isEditing in
                        if !isEditing {
                            Task {
                                await primeEventDirector.receive(.settingsPlateBackgroundMusicSlideFinishedEditing)
                            }
                        }
                    }
                )
                .disabled(!viewModel.isBackgroundMusicVolumeSliderAvailable)
                .tint(DS.SemanticColor.interactableVivid)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            DS.SemanticColor.sectionCenter,
                            DS.SemanticColor.sectionPeriphery,
                        ]),
                        center: .center,
                        startRadius: 80,
                        endRadius: 200
                    )
                )
        }
    }

    private var soundEffectSection: some View {
        ZStack {
            Spacer().frame(idealWidth: .infinity)
            VStack(alignment: .center, spacing: 0) {
                Toggle(isOn: Binding(
                    get: { viewModel.soundEffectToggleValue },
                    set: { _, _ in
                        Task {
                            await primeEventDirector.receive(.settingsPlateSoundEffectToggleTapped)
                        }
                    }
                ), label: {
                    Text(String(lKey: .settingsPlateSoundEffectSectionTitle))
                        .font(.system(size: 22))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                })
                .tint(DS.SemanticColor.interactableVivid)
                Spacer().frame(height: 15)
                Slider(
                    value: Binding(
                        get: {
                            min(max(0, viewModel.soundEffectVolumeSliderValue), 1)
                        },
                        set: { newValue, transaction in
                            Task {
                                await primeEventDirector.receive(.settingsPlateSoundEffectSlideSet(value: newValue))
                            }
                        }
                    ),
                    in: Constant.soundEffectSliderRange,
                    onEditingChanged: { isEditing in
                        if !isEditing {
                            Task {
                                await primeEventDirector.receive(.settingsPlateSoundEffectSlideFinishedEditing)
                            }
                        }
                    }
                )
                .disabled(!viewModel.isSoundEffectVolumeSliderAvailable)
                .tint(DS.SemanticColor.interactableVivid)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            DS.SemanticColor.sectionCenter,
                            DS.SemanticColor.sectionPeriphery,
                        ]),
                        center: .center,
                        startRadius: 80,
                        endRadius: 200
                    )
                )
        }
    }

    private var hapticFeedbackSection: some View {
        ZStack {
            Spacer().frame(idealWidth: .infinity)
            VStack(alignment: .center, spacing: 0) {
                Toggle(isOn: Binding(
                    get: { viewModel.hapticFeedbackToggleValue },
                    set: { _, _ in
                        Task {
                            await primeEventDirector.receive(.settingsPlateHapticFeedbackToggleTapped)
                        }
                    }
                ), label: {
                    Text(String(lKey: .settingsPlateHapticFeedbackSectionTitle))
                        .font(.system(size: 22))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                })
                .tint(DS.SemanticColor.interactableVivid)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            DS.SemanticColor.sectionCenter,
                            DS.SemanticColor.sectionPeriphery,
                        ]),
                        center: .center,
                        startRadius: 80,
                        endRadius: 200
                    )
                )
        }
    }
}

#Preview {
    SettingsPlateView(viewModel: SettingsPlateViewModel(
        backgroundMusicToggleValue: true,
        backgroundMusicVolumeSliderValue: 0.5,
        isBackgroundMusicVolumeSliderAvailable: true,
        soundEffectToggleValue: false,
        soundEffectVolumeSliderValue: 0.5,
        isSoundEffectVolumeSliderAvailable: false,
        isHapticFeedbackOn: false
    ))
}
