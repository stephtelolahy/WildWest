//
//  ResolveDynamiteExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo


class ExplodeDynamiteExecutorTests: XCTestCase {
    
    private let sut = ExplodeDynamiteExecutor()
    
    func test_DiscardDynamiteAndSetExplodeChallenge_IfExplodes() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(.dynamiteExploded),
                                 .playerDiscardInPlay("p1", "c1")])
    }
}

class PassDynamiteExecutorTests: XCTestCase {
    
    private let sut = PassDynamiteExecutor()
    
    func test_PassDynamiteToNextPlayer_IfDoesNotExplode() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.turn.get).thenReturn("p1")
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().identified(by: "p1"),
                MockPlayerProtocol().identified(by: "p2")
            ])
        }
        let move = GameMove(name: .passDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerPassInPlayOfOther("p1", "p2", "c1")])
    }
}
