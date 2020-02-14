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
    
    func test_ResolveJailDescription() {
        // Given
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 resolves c1")
    }
    
    func test_StartTurn_IfReturnHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .hearts)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
        }
        
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .flipOverFirstDeckCard,
            .playerDiscardInPlay("p1", "c1")
        ])
    }
    
    func test_SkipTurn_IfReturnNonHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().identified(by: "c1").suit(is: .clubs)
        
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1"), MockPlayerProtocol().identified(by: "p2"))
            .currentTurn(is: "p1")
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
        }
        
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .flipOverFirstDeckCard,
            .playerDiscardInPlay("p1", "c1"),
            .setTurn("p2")
        ])
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
        XCTAssertEqual(actions as? [ResolveJail], [ResolveJail(actorId: "p1", cardId: "c1")])
    }
    
    func test_ShouldResolveDynamite_BeforeResolvingJail() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"),
                     MockCardProtocol().named(.jail).identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .startTurn)
            .currentTurn(is: "p1")
        let sut = ResolveJailRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // assert
        XCTAssertNil(actions)
    }
}
