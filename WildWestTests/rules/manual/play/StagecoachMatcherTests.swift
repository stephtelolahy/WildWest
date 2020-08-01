//
//  StagecoachMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StagecoachMatcherTests: XCTestCase {
    
    private let sut = StagecoachMatcher()
    
    func test_CanPlayStagecoach_IfYourTurnAndOwnCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.stagecoach)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .stagecoach, actorId: "p1", cardId: "c1")])
    }
    
    func test_Pull2Cards_IfPlayingStagecoach() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.stagecoach))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .stagecoach, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1")])
    }
}
