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
        Cuckoo.stub(self) { mock in
            when(mock.players.get).thenReturn(players)
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
    
    func bangsPlayed(is shoots: Int) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.bangsPlayed.get).thenReturn(shoots)
        }
        return self
    }
    
    func outcome(is outcome: GameOutcome) -> MockGameStateProtocol {
           Cuckoo.stub(self) { mock in
               when(mock.outcome.get).thenReturn(outcome)
           }
           return self
       }
}
