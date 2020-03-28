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
            .challenge(is: .indians(["p1", "p2"], "px"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .bang)])
    }
    
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
