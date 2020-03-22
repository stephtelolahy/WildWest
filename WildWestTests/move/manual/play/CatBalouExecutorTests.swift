//
//  CatBalouExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CatBalouExecutorTests: XCTestCase {

    private let sut = CatBalouExecutor()

    func test_DiscardOtherPlayerHandCard_IfPlayingCatBalou() {
        // Given
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer2)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .catBalou, targetCard: TargetCard(ownerId: "p2", source: .randomHand))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p2", "c2")])
    }
    
    func test_DiscardOtherPlayerInPlayCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .catBalou, targetCard: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardInPlay("p2", "c2")])
    }
}
