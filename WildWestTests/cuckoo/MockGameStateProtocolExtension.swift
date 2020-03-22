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
    
    func eliminated(are players: PlayerProtocol...) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.eliminated.get).thenReturn(players)
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
    
    func barrelsResolved(is count: Int) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.barrelsResolved.get).thenReturn(count)
        }
        return self
    }
    
    func damageEvents(are events: DamageEvent...) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.damageEvents.get).thenReturn(events)
        }
        return self
    }
}
