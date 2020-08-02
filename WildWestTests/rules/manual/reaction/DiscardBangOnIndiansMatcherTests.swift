//
//  DiscardBangOnIndiansMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardBangOnIndiansMatcherTests: XCTestCase {
    
    private let sut = DiscardBangOnIndiansMatcher()

    func test_CanDiscardBang_IfIsTargetOfIndiansAndHoldingBangCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.bang)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2"]))
            .players(are: mockPlayer1)
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discardBang, actorId: "p1", cardId: "c1")])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfDiscardingBang() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2", "p3"]))
        let move = GameMove(name: .discardBang, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .indians, targetIds: ["p2", "p3"])),
                                 .playerDiscardHand("p1", "c1")])
    }
}
