// MARK: - Module Dependency

import Spectrum
import Agent
import PrimeEventBase

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let settingsPlateBackgroundMusicSlideFinishedEditing: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .settingsPlateBackgroundMusicSlideFinishedEditing, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in

    // 아무것도 하지 않는다.
}
