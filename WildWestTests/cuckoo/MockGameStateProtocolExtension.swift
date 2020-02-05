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
    
    func currentTurn(is turn: Int) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.turn.get).thenReturn(turn)
        }
        return self
    }
    
    func challenge(is challenge: Challenge?) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.challenge.get).thenReturn(challenge)
        }
        return self
    }
    
    func turnShoots(is shoots: Int) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.turnShoots.get).thenReturn(shoots)
        }
        return self
    }
    
    func commands(are commands: ActionProtocol...) -> MockGameStateProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.commands.get).thenReturn(commands)
        }
        return self
    }
}
