//
//  SaloonMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class SaloonMatcherTests: XCTestCase {
    
    private let sut = SaloonMatcher()
    
    func test_CanPlaySaloon_IfYourTurnAndOwnCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.saloon)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 2)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .saloon, actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotPlaySaloon_IfAllPlayersFullLife() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.saloon)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 4)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_OnlyNotMaxHealthPlayerGainLifePoints_IfPlayingSaloon() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.saloon))
            .health(is: 2)
            .maxHealth(is: 4)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockPlayer3 = MockPlayerProtocol()
            .identified(by: "p3")
            .health(is: 3)
            .maxHealth(is: 3)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1, mockPlayer2, mockPlayer3)
        let move = GameMove(name: .saloon, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerGainHealth("p1", 1),
                                 .playerGainHealth("p2", 1),
                                 .playerDiscardHand("p1", "c1")])
    }
}
