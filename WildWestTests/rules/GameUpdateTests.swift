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
    
    func test_MoveCardFromDeckToHand_IfPlayerPullCardFromDeck() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromDeck("p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).deckRemoveFirst()
        verify(mockState).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_MoveCardFromHandToDiscard_IfPlayerDiscardHand() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerDiscardHand("p1", "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveHand("p1", "c1")
        verify(mockState).addDiscard(card(equalTo: mockCard))
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
    
    func test_MoveCardFromHandToInPlay_IfPlayerPutInPlay() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPutInPlay("p1", "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveHand("p1", "c1")
        verify(mockState).playerAddInPlay("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_MoveCardFromInPlayToDiscard_IfPlayerDiscardInPlay() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveInPlay("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerDiscardInPlay("p1", "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveInPlay("p1", "c1")
        verify(mockState).addDiscard(card(equalTo: mockCard))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_AddCardToHand_IfPlayerPullFromOtherHand() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveHand("p2", "c2")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromOtherHand("p1", "p2", "c2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveHand("p2", "c2")
        verify(mockState).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_AddCardToHand_IfPlayerPullFromOtherInPlay() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveInPlay("p2", "c2")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromOtherInPlay("p1", "p2", "c2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveInPlay("p2", "c2")
        verify(mockState).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockState)
    }
    
    func test_MoveCardFromHandToInPlayOfOther_IfPlayerPutInPlayOfOther() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPutInPlayOfOther("p1", "p2", "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).playerRemoveHand("p1", "c1")
        verify(mockState).playerAddInPlay("p2", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockState)
    }
}
