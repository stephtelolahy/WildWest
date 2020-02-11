//
//  GameUpdateTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdateTests: XCTestCase {
    
    func test_setTurn() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameUpdate.setTurn("p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setTurn("p1")
        verifyNoMoreInteractions(mockState)
    }
    
    func test_removeChallenge() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameUpdate.setChallenge(nil)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(isNil())
        verifyNoMoreInteractions(mockState)
    }
    
    func test_setChallenge() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameUpdate.setChallenge(.startTurn)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(equal(to: .startTurn))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_setBangsPlayed() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameUpdate.setBangsPlayed(1)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setBangsPlayed(1)
        verifyNoMoreInteractions(mockState)
    }
    
    func test_playerPullCardFromDeck() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        Cuckoo.stub(mockState) { mock in
            when(mock.deckRemoveFirst()).thenReturn(MockCardProtocol().identified(by: "c1"))
        }
        let sut = GameUpdate.playerPullCardFromDeck("p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).deckRemoveFirst()
        verify(mockState).playerAddHandCard("p1", card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_playerDiscardHand() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveHandCard("p1", "c1")).thenReturn(MockCardProtocol().identified(by: "cx"))
        }
        let sut = GameUpdate.playerDiscardHand("p1", "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveHandCard("p1", "c1")
        verify(mockState).addDiscard(card(identifiedBy: "cx"))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_playerSetHealth() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameUpdate.playerSetHealth("p1", 2)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerSetHealth("p1", 2)
        verifyNoMoreInteractions(mockState)
    }
}
