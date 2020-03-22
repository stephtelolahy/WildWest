//
//  DiscardBeerExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardBeerExecutorTests: XCTestCase {
    
    private let sut = DiscardBeerExecutor()
    
    func test_RemoveActorFromShootChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"], .gatling, "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.shoot(["p2", "p3"], .gatling, "px"))])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"], "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.indians(["p2", "p3"], "px"))])
    }
    
    func test_RemoveDuelChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"], "p1"))
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(nil)])
    }
    
    func test_TriggerStartTurnChallenge_IfDiscardBeerOnDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .dynamiteExploded)
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1", "c2"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2"),
                                 .setChallenge(.startTurn)])
    }
}
