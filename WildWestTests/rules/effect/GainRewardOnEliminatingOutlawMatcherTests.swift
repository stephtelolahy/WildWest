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
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p2"))
            .eliminated(are: MockPlayerProtocol().identified(by: "p1").role(is: .outlaw))
            .damageEvents(are: DamageEvent(playerId: "p1", source: .byPlayer("p2")))
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .gainRewardOnEliminatingOutlaw, actorId: "p2"))
    }
    
    func test_ShouldNotGainReward_IfOutlawIsEliminatedByDynamite() {
        // Given
        let mockState = MockGameStateProtocol()
            .eliminated(are: MockPlayerProtocol().identified(by: "p1").role(is: .outlaw))
            .damageEvents(are: DamageEvent(playerId: "p1", source: .byDynamite))
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertNil(effect)
    }
}
