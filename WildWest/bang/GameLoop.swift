//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/24/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameLoopProtocol {
    func run(state: GameStateProtocol)
}

class GameLoop: GameLoopProtocol {
    
    func run(state: GameStateProtocol) {
        let rules: [RuleProtocol.Type] = [Beer.self,
                                          Saloon.self,
                                          Stagecoach.self,
                                          WellsFargo.self,
                                          Equip.self,
                                          Jail.self,
                                          Shoot.self,
                                          Missed.self,
                                          Gatling.self,
                                          Duel.self,
                                          Indians.self,
                                          Panic.self,
                                          CatBalou.self,
                                          GeneralStore.self,
                                          EndTurn.self]
        while state.outcome == nil {
            let posssibleActions = rules.map { $0.match(state: state) }.flatMap { $0 }
            let action = posssibleActions[0]
            action.execute(state: state)
            print(state)
        }
    }
}
