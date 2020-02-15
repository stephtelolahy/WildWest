//
//  PlayAllHandAI.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class PlayAllHandAI: AIProtocol {
    func chooseCommand(in state: GameStateProtocol) -> ActionProtocol? {
        if let actor = state.players.first(where: { $0.identifier == state.turn }) {
            let handCardIds = actor.hand.map { $0.identifier }
            let handCardActions = state.actions.filter { handCardIds.contains($0.cardId) }
            if let action = handCardActions.randomElement() {
                return action
            }
        }
        
        return state.actions.randomElement()
    }
}
