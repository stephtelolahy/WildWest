//
//  ActionsAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ActionItem {
    let card: CardProtocol?
    let actions: [GameMove]
}

protocol ActionsAdapter {
    func buildActions(state: GameStateProtocol, for controlledPlayerId: String?) -> [ActionItem]
}

extension ActionsAdapter {
    func buildActions(state: GameStateProtocol, for controlledPlayerId: String?) -> [ActionItem] {
        guard let controlledPlayerId = controlledPlayerId,
            let player = state.players.first(where: { $0.identifier == controlledPlayerId }) else {
                return []
        }
        
        var result: [ActionItem] = []
        var moves = state.validMoves[controlledPlayerId] ?? []
        
        player.hand.forEach { card in
            let relatedMoves = moves.filter { $0.cardId == card.identifier }
            result.append(ActionItem(card: card, actions: relatedMoves))
            moves.removeAll(where: { $0.cardId == card.identifier })
        }
        
        // show active cards first
        result = result.sorted(by: { $0.actions.count > $1.actions.count })
        
        if !moves.isEmpty {
            result.insert(ActionItem(card: nil, actions: moves), at: 0)
        }
        
        return result
    }
}
