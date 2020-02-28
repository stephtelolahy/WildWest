//
//  Eliminate.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct Eliminate: ActionProtocol, Equatable {
    let actorId: String
    let cardId = ""
    let autoPlay = true
    
    var description: String {
        "\(actorId) is eliminated"
    }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let actor = state.players.first(where: { $0.identifier == actorId }) else {
            return []
        }
        
        var updates: [GameUpdate] = []
        actor.hand.forEach { updates.append(.playerDiscardHand(actorId, $0.identifier)) }
        actor.inPlay.forEach { updates.append(.playerDiscardInPlay(actorId, $0.identifier)) }
        updates.append(.eliminatePlayer(actorId))
        if actorId == state.turn {
            updates.append(.setTurn(state.nextTurn))
            updates.append(.setChallenge(.startTurn))
        }
        return updates
    }
}

struct EliminateRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard let actor = state.players.first(where: { $0.health <= 0 }) else {
            return nil
        }
        
        return [Eliminate(actorId: actor.identifier)]
    }
}
