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
            .challenge(is: .shoot(["p1", "p2"], .gatling, "px"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])])
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
            .challenge(is: .indians(["p1", "p2"], "px"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])])
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
            .challenge(is: .duel(["p1", "p2"], "p2"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])])
    }
    
    func test_CanDiscardBeer_IfDynamiteExplodedAndWillBeEliminated() {
        // Given
        let mockCard1 = MockCardProtocol().named(.beer).identified(by: "c1")
        let mockCard2 = MockCardProtocol().named(.beer).identified(by: "c2")
        let mockCard3 = MockCardProtocol().named(.beer).identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard1, mockCard2, mockCard3)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
            .currentTurn(is: "p1")
            .challenge(is: .dynamiteExploded)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1", "c2", "c3"])])
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
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"], .gatling, "px"))
            .players(are: mockPlayer1, MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_RemoveActorFromShootChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"], .gatling, "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.shoot(["p2", "p3"], .gatling, "px"))])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"], "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.indians(["p2", "p3"], "px"))])
    }
    
    func test_RemoveDuelChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"], "p1"))
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(nil)])
    }
    
    func test_TriggerStartTurnChallenge_IfDiscardBeerOnDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .dynamiteExploded)
        let move = GameMove(name: .discard, actorId: "p1", cardName: .beer, discardIds: ["c1", "c2"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2"),
                                 .setChallenge(.startTurn)])
    }
}
