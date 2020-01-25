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
                        actions: [])
    }
    
    func test_MoveCardFromDeckToActorsHand_IfPulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockDeck) { mock in
            when(mock.removeFirst()).thenReturn(card1)
        }
        
        // When
        sut.pullFromDeck(playerId: "p1")
        
        // Assert
        verify(mockDeck).removeFirst()
        verify(mockPlayer1.mockHand).add(identified(by: "c1"))
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1.mockHand)
    }
    
    func test_ResetDeck_IfEmptyWhilePulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        Cuckoo.stub(mockDeck) { mock in
            when(mock.removeFirst()).thenReturn(nil, card1)
        }
        Cuckoo.stub(mockDiscard) { mock in
            when(mock.removeAll()).thenReturn([card1, card2])
        }
        
        // When
        sut.pullFromDeck(playerId: "p1")
        
        // Assert
        verify(mockDiscard).removeAll()
        verify(mockDeck).addAll(identified(by: ["c1", "c2"]))
        verify(mockDeck, times(2)).removeFirst()
        verify(mockPlayer1.mockHand).add(identified(by: "c1"))
        verifyNoMoreInteractions(mockDiscard)
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1.mockHand)
    }
    
    func test_MoveCardFromHandToDiscard_IfDiscarding() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1.mockHand) { mock in
            when(mock.removeById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardHand(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1.mockHand).removeById("c1")
        verify(mockDiscard).add(identified(by: "c1"))
        verifyNoMoreInteractions(mockDiscard)
        verifyNoMoreInteractions(mockPlayer1.mockHand)
        
    }
    
    /*
     func discardHand(playerId: String, cardId: String)
     func discardInPlay(playerId: String, cardId: String)
     func gainLifePoint(playerId: String)
     func pull(playerId: String)
     func putInPlay(playerId: String, cardId: String)
     */
    
}

class FullMockPlayerProtocol: MockPlayerProtocol {
    
    var mockHand: MockCardListProtocol!
    var mockInPlay: MockCardListProtocol!
    
    static func create(identifier: String) -> FullMockPlayerProtocol {
        let mockPlayer = FullMockPlayerProtocol()
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
