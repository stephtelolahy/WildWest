//
//  DiscardBangOnDuelExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardBangOnDuelExecutorTests: XCTestCase {
    
    private let sut = DiscardBangOnDuelExecutor()
    
    func test_SwitchTargetOfDuelChallenge_IfDiscardingBang() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"], "p2"))
        let move = GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .bang)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.duel(["p2", "p1"], "p2"))])
    }
    
}
