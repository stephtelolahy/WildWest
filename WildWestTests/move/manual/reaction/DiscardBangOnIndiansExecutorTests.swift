//
//  DiscardBangOnIndiansExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardBangOnIndiansExecutorTests: XCTestCase {

    private let sut = DiscardBangOnIndiansExecutor()

    func test_RemoveActorFromIndiansChallenge_IfDiscardingBang() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"], "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .bang)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.indians(["p2", "p3"], "px"))
        ])
    }
}
