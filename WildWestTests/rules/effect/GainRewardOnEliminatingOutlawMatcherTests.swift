//
//  GainRewardOnEliminatingOutlawMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GainRewardOnEliminatingOutlawMatcherTests: XCTestCase {
    
    private let sut = GainRewardOnEliminatingOutlawMatcher()
    
    func test_ShouldGainReward_IfEliminatingOutlaw() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .role(is: .outlaw)
            .lastDamage(is: DamageEvent(damage: 1, source: .byPlayer("p2")))
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p2"))
            .eliminated(are: mockPlayer1)
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .gainRewardOnEliminatingOutlaw, actorId: "p2"))
    }
    
    func test_ShouldNotGainReward_IfOutlawIsEliminatedByDynamite() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .role(is: .outlaw)
            .lastDamage(is: DamageEvent(damage: 2, source: .byDynamite))
        let mockState = MockGameStateProtocol()
            .eliminated(are: mockPlayer1)
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertNil(effect)
    }
    
    func test_Pull3Cards_IfRewardedOnEliminatingOutlaw() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .gainRewardOnEliminatingOutlaw, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 3)])
    }
}
