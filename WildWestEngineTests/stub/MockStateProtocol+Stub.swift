//
//  MockStateProtocol+Stub.swift
//  CardGameEngine_Example
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import WildWestEngine
import Cuckoo

extension MockStateProtocol {

    func withDefault() -> MockStateProtocol {
        withEnabledDefaultImplementation(StateProtocolStub())
    }
    
    func players(are players: PlayerProtocol...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.players.get).thenReturn(players.toDictionary(with: { $0.identifier }))
        }
        return self
    }
    
    func initialOrder(is players: String...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.initialOrder.get).thenReturn(players)
        }
        return self
    }

    func playOrder(is players: String...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.playOrder.get).thenReturn(players)
        }
        return self
    }

    func turn(is turn: String) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.turn.get).thenReturn(turn)
        }
        return self
    }
    
    func phase(is phase: Int) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.phase.get).thenReturn(phase)
        }
        return self
    }
    
    func distance(from player: String, to other: String, is distance: Int) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.distance(from: player, to: other)).thenReturn(distance)
        }
        return self
    }
    
    func played(are abilities: String...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.played.get).thenReturn(abilities)
        }
        return self
    }
    
    func hits(are hits: HitProtocol...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.hits.get).thenReturn(hits)
        }
        return self
    }
    
    func store(are cards: CardProtocol...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.store.get).thenReturn(cards)
        }
        return self
    }

    func deck(are cards: CardProtocol...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.deck.get).thenReturn(cards)
        }
        return self
    }

    func discard(are cards: CardProtocol...) -> MockStateProtocol {
        stub(self) { mock in
            when(mock.discard.get).thenReturn(cards)
        }
        return self
    }
}
