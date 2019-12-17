//
//  DiscardTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class DiscardTests: XCTestCase {
    
    func test_MoveCardFromHandToDeck_OnDiscard() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let mockPlayer = MockPlayerProtocol()
        let mockHand = MockCardListProtocol().withEnabledDefaultImplementation(CardListProtocolStub())
        let mockDeck = MockCardListProtocol().withEnabledDefaultImplementation(CardListProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.players.get).thenReturn([mockPlayer])
            when(mock.deck.get).thenReturn(mockDeck)
        }
        Cuckoo.stub(mockPlayer) { mock in
            when(mock.identifier.get).thenReturn("p1")
            when(mock.hand.get).thenReturn(mockHand)
        }
        Cuckoo.stub(mockHand) { mock in when(mock.cards.get).thenReturn([mockCard]) }
        Cuckoo.stub(mockCard) { mock in when(mock.identifier.get).thenReturn("c1") }
        
        // When
        let update = Discard(player: mockPlayer, card: mockCard)
        update.apply(to: mockState)
        
        // Assert
        verify(mockHand).remove(identified(by: "c1"))
        verify(mockDeck).add(identified(by: "c1"))
        verify(mockState).addMessage("p1 discard c1")
    }
    
}
