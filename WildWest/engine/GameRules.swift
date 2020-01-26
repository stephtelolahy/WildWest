//
//  GameRules.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameRulesProtocol {
    func matchingActions(for state: GameStateProtocol) -> [ActionProtocol]
}

class GameRules: GameRulesProtocol {
    
    func matchingActions(for state: GameStateProtocol) -> [ActionProtocol] {
        return ([
            Beer.match(state: state),
            Saloon.match(state: state),
            Stagecoach.match(state: state),
            WellsFargo.match(state: state),
            Equip.match(state: state),
            Jail.match(state: state),
            Shoot.match(state: state),
            Missed.match(state: state),
            Gatling.match(state: state),
            Indians.match(state: state),
            Duel.match(state: state),
            Panic.match(state: state),
            CatBalou.match(state: state),
            GeneralStore.match(state: state),
            EndTurn.match(state: state)
        ] as [[ActionProtocol]])
            .flatMap { $0 }
    }
}
