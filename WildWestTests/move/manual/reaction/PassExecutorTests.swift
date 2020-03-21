//
//  PassExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PassExecutorTests: XCTestCase {
    
    private let sut = PassExecutor()
    
    func test_LooseHealth_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .shoot(["p1"], .bang, "px"))
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("px")),
                                 .setChallenge(nil)])
    }
    
    func test_TriggerStartTurnChallenge_IfPassingOnDynamiteExploded() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .dynamiteExploded)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 3, .byDynamite),
                                 .setChallenge(.startTurn)])
    }
    
    func test_RemoveActorFromShootChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"], .gatling, "px"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("px")),
                                 .setChallenge(.shoot(["p2", "p3"], .gatling, "px"))])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"], "px"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("px")),
                                 .setChallenge(.indians(["p2", "p3"], "px"))])
    }
    
    func test_RemoveDuelChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"], "p2"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("p2")),
                                 .setChallenge(nil)])
    }
}
