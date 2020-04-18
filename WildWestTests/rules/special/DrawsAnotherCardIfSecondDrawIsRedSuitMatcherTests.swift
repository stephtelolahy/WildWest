//
//  DrawsAnotherCardIfSecondDrawIsRedSuitMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 17/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsAnotherCardIfSecondDrawIsRedSuitMatcherTests: XCTestCase {

    private let sut = StartTurnMatcher()
    
    func test_DrawsAnotherCardIfSecondDrawIsRedSuit_IfHavingAbility() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1").suit(is: .clubs)
        let mockCard2 = MockCardProtocol().identified(by: "c2").suit(is: .hearts)
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsAnotherCardIfSecondDrawIsRedSuit: true])
            .holding(MockCardProtocol().suit(is: .clubs), MockCardProtocol().suit(is: .diamonds))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .deckCards(are: mockCard1, mockCard2)
        let move = GameMove(name: .startTurn, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerRevealHandCard("p1", "c2"),
                                 .playerPullFromDeck("p1"),
                                 .setChallenge(nil)])
    }
    
    func test_DoNotDrawsAnotherCardIfSecondDrawIsNotRedSuit_IfHavingAbility() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1").suit(is: .clubs)
        let mockCard2 = MockCardProtocol().identified(by: "c2").suit(is: .spades)
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsAnotherCardIfSecondDrawIsRedSuit: true])
            .holding(MockCardProtocol().suit(is: .clubs), MockCardProtocol().suit(is: .diamonds))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .deckCards(are: mockCard1, mockCard2)
        let move = GameMove(name: .startTurn, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerRevealHandCard("p1", "c2"),
                                 .setChallenge(nil)])
    }

}
