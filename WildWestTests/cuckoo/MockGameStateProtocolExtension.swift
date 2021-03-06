//
//  MockGameStateProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockGameStateProtocol {
    
    func players(are players: PlayerProtocol...) -> MockGameStateProtocol {
        let mockPlayers = players.map({ $0 as! MockPlayerProtocol })
        mockPlayers.forEach { mockPlayer in
            Cuckoo.stub(mockPlayer) { mock in
                when(mock.health.get).thenReturn(4)
            }
        }
        
        Cuckoo.stub(self) { mock in
            when(mock.allPlayers.get).thenReturn(players)
        }
        return self
    }
    
    func allPlayers(are players: PlayerProtocol...) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.allPlayers.get).thenReturn(players)
        }
        return self
    }
    
    func currentTurn(is playerId: String) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.turn.get).thenReturn(playerId)
        }
        return self
    }
    
    func challenge(is challenge: Challenge?) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.challenge.get).thenReturn(challenge)
        }
        return self
    }
    
    func topDiscardPile(is card: CardProtocol?) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            if let card = card {
                when(mock.discardPile.get).thenReturn([card])
            } else {
                when(mock.discardPile.get).thenReturn([])
            }
        }
        return self
    }
    
    func deckCards(are cards: CardProtocol...) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.deck.get).thenReturn(cards)
        }
        return self
    }
}
