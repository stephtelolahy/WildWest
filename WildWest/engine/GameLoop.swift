//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/24/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameLoop: GameLoopProtocol {
    
    func posssibleActions(state: GameStateProtocol) -> [ActionProtocol] {
        var result: [ActionProtocol] = []
        result.append(contentsOf: Beer.match(state: state) ?? [])
        result.append(contentsOf: Saloon.match(state: state) ?? [])
        result.append(contentsOf: Stagecoach.match(state: state) ?? [])
        result.append(contentsOf: WellsFargo.match(state: state) ?? [])
        result.append(contentsOf: Equip.match(state: state) ?? [])
        result.append(contentsOf: Jail.match(state: state) ?? [])
        result.append(contentsOf: Shoot.match(state: state) ?? [])
        result.append(contentsOf: Missed.match(state: state) ?? [])
        result.append(contentsOf: Gatling.match(state: state) ?? [])
        result.append(contentsOf: Indians.match(state: state) ?? [])
        result.append(contentsOf: Duel.match(state: state) ?? [])
        result.append(contentsOf: Panic.match(state: state) ?? [])
        result.append(contentsOf: CatBalou.match(state: state) ?? [])
        result.append(contentsOf: GeneralStore.match(state: state) ?? [])
        result.append(contentsOf: EndTurn.match(state: state) ?? [])
        return result
    }
    
    func run(state: GameStateProtocol) {
        while state.outcome == nil {
            guard let action = posssibleActions(state: state).first else {
                break
            }
            
            action.execute(state: state)
            print(state)
        }
    }
}
