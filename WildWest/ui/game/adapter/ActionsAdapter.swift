//
//  ActionsAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ActionItem {
    let card: CardProtocol?
    let actions: [ActionProtocol]
}

enum ActionsAdapter {
    
    static func buildActions(state: GameStateProtocol, for controlledPlayerId: String?) -> [ActionItem] {
        guard let controlledPlayerId = controlledPlayerId,
            let player = state.players.first(where: { $0.identifier == controlledPlayerId }) else {
                return []
        }
        
        var result: [ActionItem] = []
        var actions = state.validMoves.filter { $0.actorId == controlledPlayerId }
        player.hand.forEach { card in
            let cardActions = actions.filter { ($0 as? PlayCardAtionProtocol)?.cardId == card.identifier }
            result.append(ActionItem(card: card, actions: cardActions))
            actions.removeAll(where: { ($0 as? PlayCardAtionProtocol)?.cardId == card.identifier })
        }
        if !actions.isEmpty {
            result.insert(ActionItem(card: nil, actions: actions), at: 0)
        }
        return result
    }
    
    static func buildInstruction(state: GameStateProtocol, for controlledPlayerId: String?) -> String {
        if let outcome = state.outcome {
            return outcome.rawValue
        }
        
        if let challenge = state.challenge {
            return challenge.description
        }
        
        guard let controlledPlayerId = controlledPlayerId,
            state.validMoves.contains(where: { $0.actorId == controlledPlayerId }) else {
                return "waiting others to play"
        }
        
        return "your turn"
    }
}
