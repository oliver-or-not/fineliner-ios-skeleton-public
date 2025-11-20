// MARK: - Module Dependency

import Foundation
import Spectrum
import Agent
import PrimeEventBase

// MARK: - Context

fileprivate let appInfoAgent = GlobalEntity.Agent.appInfoAgent
fileprivate let appStateAgent = GlobalEntity.Agent.appStateAgent
fileprivate let dateAgent = GlobalEntity.Agent.dateAgent
fileprivate let soundAgent = GlobalEntity.Agent.soundAgent
fileprivate let plateStackAgent = GlobalEntity.Agent.plateStackAgent
fileprivate let googleAdAgent = GlobalEntity.Agent.googleAdAgent
fileprivate let basicGamePlate = GlobalEntity.Plate.basicGamePlate

// MARK: - Body

extension GlobalEntity.PrimeEvent {

    public static let mainPlateGameStartButtonTapped: GlobalEntity.PrimeEvent.Interface
    = BasePrimeEvent(designation: .mainPlateGameStartButtonTapped, task: task)
}

fileprivate let task: BasePrimeEvent.Task = { _ in

    let now = await dateAgent.getNowDate()

    // MARK: - Present Basic Game Plate

    await plateStackAgent.pushPlate(.basicGame, .fadeIn)

    // MARK: - Sound

    await soundAgent.playBackgroundMusic(.basicGameBackgroundMusic)

    // MARK: - Load Full Ad

    let lastLoadedDateOfBasicGameFinishDialogFullAd = await appStateAgent.getLastLoadedDateOfBasicGameFinishDialogFullAd()
    let isFullAdConsumed = await googleAdAgent.getIsFullAdConsumed()

    if let lastLoadedDateOfBasicGameFinishDialogFullAd,
       now < lastLoadedDateOfBasicGameFinishDialogFullAd.addingTimeInterval(60 * 30),
       !isFullAdConsumed {
        _ = 0
    } else {
        await appStateAgent.setLastLoadedDateOfBasicGameFinishDialogFullAd(now)

        let fullAdUnitId = await appInfoAgent.getCustomGoogleAdUnitIdForResultDialogFullAd()
        await googleAdAgent.loadFullAd(fullAdUnitId: fullAdUnitId)
    }
}
