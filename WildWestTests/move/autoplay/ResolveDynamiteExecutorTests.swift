//
//  ResolveDynamiteExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ResolveDynamiteExecutorTests: XCTestCase {
    
    private let sut = ResolveDynamiteExecutor()
    
    func test_PassDynamiteToNextPlayer_IfDoesNotExplode() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .diamonds)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
            when(mock.turn.get).thenReturn("p1")
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().identified(by: "p1"),
                MockPlayerProtocol().identified(by: "p2")
            ])
        }
        let move = GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .dynamite)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerPassInPlayOfOther("p1", "p2", "c1")])
    }
    
    func test_DiscardDynamiteAndSetExplodeChallenge_IfExplodes() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .spades).value(is: "3")
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
        }
        let move = GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .dynamite)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(.dynamiteExploded),
                                 .playerDiscardInPlay("p1", "c1")])
    }
}
