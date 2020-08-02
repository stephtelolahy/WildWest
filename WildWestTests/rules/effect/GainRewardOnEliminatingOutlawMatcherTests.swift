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
            .health(is: 0)
            .lastDamage(is: DamageEvent(damage: 1, source: .byPlayer("p2")))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 2)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1, mockPlayer2)
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
            .health(is: 0)
            .lastDamage(is: DamageEvent(damage: 2, source: .byDynamite))
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1)
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
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1")])
    }
}
