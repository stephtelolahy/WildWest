//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var players: [PlayerProtocol] { get set }
    var deck: [Card] { get set }
    var discard: [Card] { get set }
    var outcome: GameOutcome? { get set }
}

enum GameOutcome {
    case sheriffWins,
    outlawWin,
    renegadeWins
}
