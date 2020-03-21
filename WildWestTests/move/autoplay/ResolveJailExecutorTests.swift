
//
//  ResolveJailExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ResolveJailExecutorTests: XCTestCase {
    
    private let sut = ResolveJailExecutor()
    
    func test_DiscardJail_IfReturnHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .hearts)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
        }
        let move = GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .jail)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerDiscardInPlay("p1", "c1")])
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
        let move = GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .jail)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerDiscardInPlay("p1", "c1"),
                                 .setTurn("p2"),
                                 .setChallenge(.startTurn)])
    }
}
