//
//  Discard2CardsFor1LifeMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class Discard2CardsFor1LifeMatcherTests: XCTestCase {
    
    private let sut = Discard2CardsFor1LifeMatcher()
    
    func test_CanDiscard2CardsFor1Life_IfHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.canDiscard2CardsFor1Life: true])
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"))
            .health(is: 1)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1)
            .challenge(is: nil)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard2CardsFor1Life, actorId: "p1", discardIds: ["c1", "c2"])])
    }
    
    func test_CannotDiscard2CardsFor1Life_IfHavingAbilityButNotEnoughCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.canDiscard2CardsFor1Life: true])
            .holding(MockCardProtocol())
            .health(is: 1)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1)
            .challenge(is: nil)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_ExecutingDiscard2CardsFor1Life() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1)
        let move = GameMove(name: .discard2CardsFor1Life, actorId: "p1", discardIds: ["c1", "c2"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerSetHealth("p1", 2),
                                 .playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2")])
    }
    
}
