//
//  EndTurnMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EndTurnMatcherTests: XCTestCase {
    
    private let sut = EndTurnMatcher()
    
    func test_CanEndTurnWithoutDicardingExcessCards_IfPlayingNoChallenge() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
            .holding(MockCardProtocol(), MockCardProtocol(), MockCardProtocol())
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .endTurn, actorId: "p1")])
    }
    
    func test_CanEndTurnWithDicardingExcessCards_IfPlayingNoChallenge() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(MockCardProtocol(), MockCardProtocol(), MockCardProtocol())
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .endTurn, actorId: "p1")])
    }
    
    func test_ChangeTurnToNextPlayer_IfAPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .noCardsInHand()
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p2"),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
    
    func test_ChangeTurnToFirstPlayer_IfLastPlayerJustEndedTurn() {
        // Given
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 1)
            .noCardsInHand()
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p1"),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
    
    func test_SetDiscardExcessCardsChallenge_IfEndingTurnWithExcessCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(MockCardProtocol(), MockCardProtocol(), MockCardProtocol())
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1)
        let move = GameMove(name: .endTurn, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .discardExcessCards, actorId: "p1"))])
    }
}
