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
    func buildActions(state: GameStateProtocol,
                      validMoves: [GameMove],
                      for controlledPlayerId: String?) -> [ActionItem]
}

class ActionsAdapter: ActionsAdapterProtocol {
    func buildActions(state: GameStateProtocol,
                      validMoves: [GameMove],
                      for controlledPlayerId: String?) -> [ActionItem] {
        guard let controlledPlayerId = controlledPlayerId,
            let player = state.player(controlledPlayerId) else {
                return []
        }
        
        return player.hand.map { card in
            let moves = validMoves.filter { $0.cardId == card.identifier }
            return ActionItem(card: card, moves: moves)
        }
    }
}
