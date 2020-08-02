//
//  DiscardBeerMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardBeerMatcherTests: XCTestCase {
    
    private let sut = DiscardBeerMatcher()
    
    func test_CanDiscardBeer_IfIsTargetOfShootAndWillBeEliminated() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2"], damage: 1))
            .allPlayers(are: mockPlayer1, MockPlayerProtocol().health(is: 1), MockPlayerProtocol().health(is: 1))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")])
    }
    
    func test_CanDiscardBeer_IfIsTargetOfIndiansAndWillBeEliminated() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2"], damage: 1))
            .allPlayers(are: mockPlayer1, MockPlayerProtocol().health(is: 1), MockPlayerProtocol().health(is: 1))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")])
    }
    
    func test_CanDiscardBeer_IfIsTargetOfDuelAndWillBeEliminated() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .duel, targetIds: ["p1", "p2"], damage: 1))
            .allPlayers(are: mockPlayer1, MockPlayerProtocol().health(is: 1), MockPlayerProtocol().health(is: 1))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")])
    }
    
    func test_CanDiscardBeer_IfDynamiteExplodedAndWillBeEliminated() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1, MockPlayerProtocol().health(is: 1), MockPlayerProtocol().health(is: 1))
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .dynamiteExploded, damage: 3))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotDiscardBeer_IfDynamiteExplodes_OnHealthIs4() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .dynamiteExploded))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotDiscardBeer_IfThereAreTwoPlayersLeft() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2"]))
            .allPlayers(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_ReduceDamage_IfDiscardBeerOnDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .dynamiteExploded, damage: 3))
        let move = GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .dynamiteExploded, damage: 2)), .playerDiscardHand("p1", "c1")])
    }
    
    func test_TriggerStartTurnChallenge_IfDiscardBeerOnDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .dynamiteExploded, damage: 1))
        let move = GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .startTurn)),
                                 .playerDiscardHand("p1", "c1")])
    }
    
    func test_RemoveActorFromBangChallenge_IfDiscardingBeer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], damage: 1))
            .players(are: mockPlayer1)
        let move = GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerDiscardHand("p1", "c1")])
    }
    
    func test_RemoveActorFromGatlingChallenge_IfDiscardingBeer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2", "p3"]))
            .players(are: mockPlayer1)
        let move = GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .gatling, targetIds: ["p2", "p3"])),
                                 .playerDiscardHand("p1", "c1")])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfDiscardingBeer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2", "p3"], damage: 1))
            .players(are: mockPlayer1)
        let move = GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .indians, targetIds: ["p2", "p3"], damage: 1)),
                                 .playerDiscardHand("p1", "c1")])
    }
    
    func test_RemoveDuelChallenge_IfDiscardingBeer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .challenge(is: Challenge(name: .duel, targetIds: ["p1", "p2"]))
            .players(are: mockPlayer1)
        let move = GameMove(name: .discardBeer, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerDiscardHand("p1", "c1")])
    }
}
