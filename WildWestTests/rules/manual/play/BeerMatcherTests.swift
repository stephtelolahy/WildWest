//
//  BeerMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class BeerMatcherTests: XCTestCase {
    
    private let sut = BeerMatcher()
    
    func test_CanPlayBeer_IfYourTurnAndOwnCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer, MockPlayerProtocol().health(is: 1), MockPlayerProtocol().health(is: 1))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .beer, actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotPlayBeer_IfMaxHealth() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard)
            .health(is: 4)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer)
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotPlayBeer_IfThereAreOnly2PlayersLeft() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol())
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_GainLifePoint_IfPlayingBeer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.beer).identified(by: "c1"))
            .health(is: 2)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1)
        let move = GameMove(name: .beer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerSetHealth("p1", 3),
                                 .playerDiscardHand("p1", "c1")])
    }
    
}
