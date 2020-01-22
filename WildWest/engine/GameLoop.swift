//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/24/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameLoop: GameLoopProtocol {
    
    func posssibleActions(state: GameStateProtocol) -> [ActionProtocol] {
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
            EndTurn.match(state: state),
            BeerLastLifePoint.match(state: state)
        ] as [[ActionProtocol]])
            .flatMap { $0 }
    }
    
    func run(state: GameStateProtocol) {
        while state.outcome == nil {
            let action = posssibleActions(state: state)[0]
            action.execute(state: state)
            print(state)
        }
    }
}
