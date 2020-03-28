//
//  ActionsAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ActionItem {
    let card: CardProtocol
    let moves: [GameMove]
}

protocol ActionsAdapterProtocol {
    func buildActions(state: GameStateProtocol, for controlledPlayerId: String?) -> [ActionItem]
}

class ActionsAdapter: ActionsAdapterProtocol {
    func buildActions(state: GameStateProtocol, for controlledPlayerId: String?) -> [ActionItem] {
        guard let controlledPlayerId = controlledPlayerId,
            let player = state.players.first(where: { $0.identifier == controlledPlayerId }) else {
                return []
        }
        
        let playerMoves = state.validMoves[controlledPlayerId] ?? []
        return player.hand.map { card in
            ActionItem(card: card,
                       moves: playerMoves.filter { $0.cardId == card.identifier })
        }
    }
}
