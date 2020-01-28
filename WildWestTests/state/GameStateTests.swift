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
    
    private var sut: GameState!
    
    private var mockPlayer1: FullMockPlayerProtocol!
    private var mockDeck: MockCardListProtocol!
    private var mockDiscard: MockCardListProtocol!
    
    override func setUp() {
        mockDeck = MockCardListProtocol().withEnabledDefaultImplementation(CardListProtocolStub())
        mockDiscard = MockCardListProtocol().withEnabledDefaultImplementation(CardListProtocolStub())
        mockPlayer1 = FullMockPlayerProtocol.create(identifier: "p1")
        sut = GameState(players: [mockPlayer1],
                        deck: mockDeck,
                        discard: mockDiscard,
                        turn: 0,
                        outcome: nil,
                        history: [],
                        actions: [],
                        challenge: nil)
    }
    
    func test_MoveCardFromDeckToActorsHand_IfPulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockDeck) { mock in
            when(mock.cards.get).thenReturn([card1])
            when(mock.removeFirst()).thenReturn(card1)
        }
        
        // When
        sut.pullFromDeck(playerId: "p1")
        
        // Assert
        verify(mockDeck).cards.get()
        verify(mockDeck).removeFirst()
        verify(mockPlayer1.mockHand).add(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1.mockHand)
    }
    
    func test_ResetDeck_IfEmptyWhilePulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockDeck) { mock in
            when(mock.cards.get).thenReturn([])
            when(mock.removeFirst()).thenReturn(card1)
        }
        Cuckoo.stub(mockDiscard) { mock in
            when(mock.removeAll()).thenReturn([card1])
        }
        
        // When
        sut.pullFromDeck(playerId: "p1")
        
        // Assert
        verify(mockDiscard).removeAll()
        verify(mockDeck).cards.get()
        verify(mockDeck).addAll(cards(identifiedBy: ["c1"]))
        verify(mockDeck).removeFirst()
        verify(mockPlayer1.mockHand).add(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDiscard)
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1.mockHand)
    }
    
    func test_MoveCardFromHandToDiscard_IfDiscardingHand() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1.mockHand) { mock in
            when(mock.removeById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardHand(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1.mockHand).removeById("c1")
        verify(mockDiscard).add(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockPlayer1.mockHand)
        verifyNoMoreInteractions(mockDiscard)
    }
    
    func test_MoveCardFromInPlayToDiscard_IfDiscardingInPlay() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1.mockInPlay) { mock in
            when(mock.removeById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardInPlay(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1.mockInPlay).removeById("c1")
        verify(mockDiscard).add(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockPlayer1.mockInPlay)
        verifyNoMoreInteractions(mockDiscard)
    }
    
    func test_IncrementHealth_IfGainingLifePoint() {
        // Given
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.health.get).thenReturn(2)
        }
        
        // When
        sut.gainLifePoint(playerId: "p1")
        
        // Assert
        verify(mockPlayer1).setHealth(3)
    }
    
    func test_MoveCardFromHandToInPlay_ifPuttingInPlay() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1.mockHand) { mock in
            when(mock.removeById("c1")).thenReturn(card1)
        }
        
        // When
        sut.putInPlay(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1.mockHand).removeById("c1")
        verify(mockPlayer1.mockInPlay).add(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockPlayer1.mockHand)
        verifyNoMoreInteractions(mockPlayer1.mockInPlay)
    }
    
    func test_SetTurn() {
        // Given
        // When
        sut.setTurn(1)
        
        // Assert
        XCTAssertEqual(sut.turn, 1)
    }
}

private class FullMockPlayerProtocol: MockPlayerProtocol {
    
    var mockHand: MockCardListProtocol!
    var mockInPlay: MockCardListProtocol!
    
    static func create(identifier: String) -> FullMockPlayerProtocol {
        let mockPlayer = FullMockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub())
        let mockHand = MockCardListProtocol().withEnabledDefaultImplementation(CardListProtocolStub())
        let mockInPlay = MockCardListProtocol().withEnabledDefaultImplementation(CardListProtocolStub())
        Cuckoo.stub(mockPlayer) { mock in
            when(mock.identifier.get).thenReturn(identifier)
            when(mock.hand.get).thenReturn(mockHand)
            when(mock.inPlay.get).thenReturn(mockInPlay)
        }
        mockPlayer.mockHand = mockHand
        mockPlayer.mockInPlay = mockInPlay
        return mockPlayer
    }
}
