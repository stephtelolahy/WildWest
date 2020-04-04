//
//  DrawsCardWhenHandIsEmptyMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsCardWhenHandIsEmptyMatcherTests: XCTestCase {

    private let sut = DrawsCardWhenHandIsEmptyMatcher()
    
    func test_ShouldDrawCardWhenHandIsEmpty_IfHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardWhenHandIsEmpty: true])
            .noCardsInHand()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .drawsCardWhenHandIsEmpty, actorId: "p1"))
    }
    
    func test_ExecutingDrawCardWhenHandIsEmpty() {
        // Given
        let move = GameMove(name: .drawsCardWhenHandIsEmpty, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: MockGameStateProtocol())
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 1)])
    }

}
