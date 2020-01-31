//
//  GameStateTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameStateTests: XCTestCase {
    
    private var sut: GameStateProtocol!
    
    private var mockPlayer1: MockPlayerProtocol!
    private var mockDeck: MockDeckProtocol!
    
    override func setUp() {
        mockDeck = MockDeckProtocol().withEnabledDefaultImplementation(DeckProtocolStub())
        mockPlayer1 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p1")
        sut = GameState(players: [mockPlayer1],
                        deck: mockDeck,
                        turn: 0,
                        challenge: nil,
                        outcome: nil,
                        commands: [])
    }
    
    func test_InitialProperties() {
        // Given
        // When
        // Assert
        XCTAssertTrue(sut.players[0] as? MockPlayerProtocol === mockPlayer1)
        XCTAssertTrue(sut.deck as? MockDeckProtocol === mockDeck)
        XCTAssertNil(sut.challenge)
        XCTAssertTrue(sut.commands.isEmpty)
        XCTAssertNil(sut.outcome)
    }
    
    func test_MoveCardFromDeckToActorsHand_IfPulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockDeck) { mock in
            when(mock.pull()).thenReturn(card1)
        }
        
        // When
        sut.pullFromDeck(playerId: "p1")
        
        // Assert
        verify(mockDeck).pull()
        verifyNoMoreInteractions(mockDeck)
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).addHand(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_MoveCardFromHandToDiscard_IfDiscardingHand() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.removeHandById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardHand(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).removeHandById("c1")
        verifyNoMoreInteractions(mockPlayer1)
        verify(mockDeck).addToDiscard(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDeck)
    }
    
    func test_MoveCardFromInPlayToDiscard_IfDiscardingInPlay() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.removeInPlayById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardInPlay(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).removeInPlayById("c1")
        verifyNoMoreInteractions(mockPlayer1)
        verify(mockDeck).addToDiscard(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDeck)
    }
    
    func test_IncrementHealth_IfGainingLifePoint() {
        // Given
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.health.get).thenReturn(2)
        }
        
        // When
        sut.gainLifePoint(playerId: "p1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).health.get()
        verify(mockPlayer1).setHealth(3)
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_MoveCardFromHandToInPlay_ifPuttingInPlay() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.removeHandById("c1")).thenReturn(card1)
        }
        
        // When
        sut.putInPlay(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).removeHandById("c1")
        verify(mockPlayer1).addInPlay(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_SetTurn() {
        // Given
        // When
        sut.setTurn(1)
        
        // Assert
        XCTAssertEqual(sut.turn, 1)
    }
    
    func test_AddCommand() {
        // Given
        let mockAction = MockActionProtocol().described(by: "ac")
        
        // When
        sut.addCommand(mockAction)
        
        // Assert
        XCTAssertEqual(sut.commands.last?.description, "ac")
    }
    
    func test_SetSomeChallenge() {
        // Given
        // When
        sut.setChallenge(.startTurn)
        
        // Assert
        XCTAssertEqual(sut.challenge, .startTurn)
    }
    
    func test_RemoveChallenge() {
        // Given
        // When
        sut.setChallenge(nil)
        
        // Assert
        XCTAssertNil(sut.challenge)
    }
}
