//
//  DiscardExcessCardMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardExcessCardMatcherTests: XCTestCase {
    
    private let sut = DiscardExcessCardMatcher()
    
    func test_CanDiscardOneCard_IfChallengedByDiscardExcessCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .discardExcessCards))
            .players(are: MockPlayerProtocol()
                .identified(by: "p1")
                .holding(MockCardProtocol().identified(by: "c1"),
                         MockCardProtocol().identified(by: "c2")))
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discardExcessCards, actorId: "p1", cardId: "c1"),
                               GameMove(name: .discardExcessCards, actorId: "p1", cardId: "c2")])
    }
    
    func test_DiscardCardAndChangeTurn_IfExecutingDiscardExcessCard() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
            .challenge(is: Challenge(name: .discardExcessCards))
        let move = GameMove(name: .discardExcessCards, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setTurn("p2"),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
    
    func test_ContinueDiscardCard_IfExecutingDiscardExcessCard() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"),
                     MockCardProtocol().identified(by: "c3"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
            .challenge(is: Challenge(name: .discardExcessCards))
        let move = GameMove(name: .discardExcessCards, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1")])
    }
    
}
