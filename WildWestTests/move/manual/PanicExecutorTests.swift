//
//  PanicExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PanicExecutorTests: XCTestCase {
    
    private let sut = PanicExecutor()
    
    func test_PullOtherPlayerHandCard_IfPlayingPanic() {
        // Given
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer2)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p2", source: .randomHand))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromOtherHand("p1", "p2", "c2")])
    }
    
    func test_PullOtherPlayerInPlayCard_IfPlayingPanic() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromOtherInPlay("p1", "p2", "c2")])
    }
    
}
