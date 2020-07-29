//
//  HandAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct HandItem {
    let card: CardProtocol
    let moves: [GameMove]
}

protocol HandAdapterProtocol {
    func buildItems(validMoves: [GameMove],
                    state: GameStateProtocol?) -> [HandItem]
}

class HandAdapter: HandAdapterProtocol {
    
    private let playerId: String?
    
    init(playerId: String?) {
        self.playerId = playerId
    }
    
    func buildItems(validMoves: [GameMove], state: GameStateProtocol?) -> [HandItem] {
        guard let controlledPlayerId = playerId,
            let player = state?.player(controlledPlayerId) else {
                return []
        }
        
        return player.hand.map { card in
            let moves = validMoves.filter { $0.cardId == card.identifier }
            return HandItem(card: card, moves: moves)
        }
    }
}
