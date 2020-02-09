//
//  ResolveJailTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ResolveJailTests: XCTestCase {
    
    func test_ResolveJainDescription() {
        // Given
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 resolves c1")
    }
    
    func test_DiscardJail_IfResolvingJail() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .deck(is: MockDeckProtocol().withEnabledDefaultImplementation(DeckProtocolStub()))
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardInPlay(playerId: "p1", cardId: "c1")
    }
    
    func test_RevealCardFromDeck_IfResolvingJail() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .deck(is: MockDeckProtocol().withEnabledDefaultImplementation(DeckProtocolStub()))
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).revealDeck()
    }
    
    func test_StartTurn_IfReturnHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .hearts)
        let mockDeck = MockDeckProtocol()
        Cuckoo.stub(mockDeck) { mock in
            when(mock.discardPile.get).thenReturn([mockCard, MockCardProtocol()])
        }
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .deck(is: mockDeck)
            .currentTurn(is: "p1")
        
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState, never()).setTurn(anyString())
    }
    
    func test_SkipTurn_IfReturnNonHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().identified(by: "c1").suit(is: .clubs)
        let mockDeck = MockDeckProtocol()
        Cuckoo.stub(mockDeck) { mock in
            when(mock.discardPile.get).thenReturn([mockCard, MockCardProtocol()])
        }
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: MockPlayerProtocol().identified(by: "p1"), MockPlayerProtocol().identified(by: "p2"))
            .deck(is: mockDeck)
            .currentTurn(is: "p1")
        
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setTurn("p2")
    }
}

class ResolveJailRuleTests: XCTestCase {
    
    func test_ShouldResolveJail_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .startTurn)
            .currentTurn(is: "p1")
        let sut = ResolveJailRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "resolve jail")
        XCTAssertNil(actions?[0].cardId)
        XCTAssertEqual(actions?[0].options as? [ResolveJail], [ResolveJail(actorId: "p1", cardId: "c1")])
    }
}
