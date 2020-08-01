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
            .allPlayers(are: mockPlayer)
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .endTurn, actorId: "p1")])
    }
    
    func test_CanEndTurnWithDicardingExcessCards_IfPlayingNoChallenge() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer)
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .endTurn, actorId: "p1", discardIds: ["c1"]),
                               GameMove(name: .endTurn, actorId: "p1", discardIds: ["c2"])])
    }
    
    func test_ChangeTurnToNextPlayer_IfAPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .noCardsInHand()
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 2)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
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
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .allPlayers(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p2")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p1"),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
    
    func test_DiscardExcessCards_IfEndingTurnWithExcessCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p1", discardIds: ["c1", "c2"])
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p2"),
                                 .setChallenge(Challenge(name: .startTurn)),
                                 .playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2")])
    }
}
