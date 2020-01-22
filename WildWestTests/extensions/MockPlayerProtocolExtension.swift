//
//  MockPlayerProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockPlayerProtocol {
    func identified(by identifier: String) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.identifier.get).thenReturn(identifier)
        }
        return self
    }
    
    func holding(_ cards: CardProtocol...) -> MockPlayerProtocol {
        let mockHand = MockCardListProtocol()
        Cuckoo.stub(mockHand) { mock in
            when(mock.cards.get).thenReturn(cards)
        }
        
        Cuckoo.stub(self) { mock in
            when(mock.hand.get).thenReturn(mockHand)
        }
        return self
    }
    
    func health(is health: Int) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.health.get).thenReturn(health)
        }
        return self
    }
    
    func maxHealth(is maxHealth: Int) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.maxHealth.get).thenReturn(maxHealth)
        }
        return self
    }
    
    func playing(_ cards: CardProtocol...) -> MockPlayerProtocol {
        let mockInPlay = MockCardListProtocol()
        Cuckoo.stub(mockInPlay) { mock in
            when(mock.cards.get).thenReturn(cards)
        }
        
        Cuckoo.stub(self) { mock in
            when(mock.inPlay.get).thenReturn(mockInPlay)
        }
        return self
    }
    
    func noCardsInPlay() -> MockPlayerProtocol {
        let mockInPlay = MockCardListProtocol()
        Cuckoo.stub(mockInPlay) { mock in
            when(mock.cards.get).thenReturn([])
        }
        
        Cuckoo.stub(self) { mock in
            when(mock.inPlay.get).thenReturn(mockInPlay)
        }
        return self
    }
}
