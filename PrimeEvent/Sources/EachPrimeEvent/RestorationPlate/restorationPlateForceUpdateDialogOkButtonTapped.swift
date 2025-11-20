// MARK: - Module Dependency

import Spectrum
import Director
import Agent
import Plate
import PrimeEventBase

// MARK: - Context

fileprivate let logDirector = GlobalEntity.Director.log

fileprivate let appSwitchAgent = GlobalEntity.Agent.appSwitchAgent

fileprivate let restorationPlate = GlobalEntity.Plate.restorationPlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let restorationPlateForceUpdateDialogOkButtonTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .restorationPlateForceUpdateDialogOkButtonTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in

    // 강제 업데이트 다이얼로그를 닫지 않는다.
    // 메인 화면으로 이동하지도 않는다.

    // MARK: - Open App Store

    do {
        try await appSwitchAgent.switchTo(.appStorePageOfThisApp)
    } catch {
        await logDirector.primeEventLog(
            .restorationPlateForceUpdateDialogOkButtonTapped,
            .error,
            "Failed to switch to App Store page of this app. error: \(error)"
        )
    }
}
