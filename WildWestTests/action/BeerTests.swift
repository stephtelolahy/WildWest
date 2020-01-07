//
//  BeerTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class BeerTests: XCTestCase {
    
    func test_GainLifePoint_IfPlayingBeer() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let beer = Beer(actorId: "p1", cardId: "c1")
        
        // When
        beer.execute(state: mockState)
        
        // Assert
        verify(mockState).discard(playerId: "p1", cardId: "c1")
        verify(mockState).gainLifePoint(playerId: "p1")
        verifyNoMoreInteractions(mockState)
    }
    
    func test_CanPlayBeer_IfOwnBeerCard() {
        // Given
        let mockState = MockGameStateProtocol()
        let mockPlayer = MockPlayerProtocol()
        let mockHand = MockCardListProtocol()
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.turn.get).thenReturn(0)
            when(mock.players.get).thenReturn([mockPlayer])
        }
        Cuckoo.stub(mockPlayer) { mock in
            when(mock.identifier.get).thenReturn("p1")
            when(mock.hand.get).thenReturn(mockHand)
        }
        Cuckoo.stub(mockHand) { mock in
            when(mock.cards.get).thenReturn([mockCard])
        }
        Cuckoo.stub(mockCard) { mock in
            when(mock.identifier.get).thenReturn("c1")
            when(mock.name.get).thenReturn(.beer)
        }
        
        // When
        let actions = Beer.match(state: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Beer], [Beer(actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotGainMoreLifePointsThanYourStartingAmount() {
        // Given
        
        // When
        //let actions = Beer.match(state: mockState)
        
        // Assert
        // You cannot gain more life points than your starting amount!
        XCTFail()
    }
    
    func test_BeerHasNoEffect_IfThereAreOnly2PlayersLeft() {
        // Beer has no effect if there are only 2 players left in the game
        XCTFail()
    }
}
