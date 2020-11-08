//
//  HandAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
import CardGameEngine

struct HandItem {
    let card: CardProtocol
    let moves: [GMove]
}

protocol HandAdapterProtocol {
    func buildItems(validMoves: [GMove], state: StateProtocol) -> [HandItem]
}

class HandAdapter: HandAdapterProtocol {
    
    private let playerId: String
    
    init(playerId: String) {
        self.playerId = playerId
    }
    
    func buildItems(validMoves: [GMove], state: StateProtocol) -> [HandItem] {
        state.players[playerId]!.hand.map { card in
            HandItem(card: card, 
                     moves: validMoves.filter { $0.isPlaying(card.identifier) })
        }
    }
}

private extension GMove {
    
    func isPlaying(_ cardId: String) -> Bool {
        if case let .hand(aCard) = card, 
           cardId == aCard {
            return true
        }
        
        if ["equip", "handicap"].contains(ability),
           args[.requiredHand] == [cardId] {
            return true
        }
        
        return false
    }
}
