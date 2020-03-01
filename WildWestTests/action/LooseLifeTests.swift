//
//  LooseLifeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class LooseLifeTests: XCTestCase {
    
    func test_LooseLifePointDescription() {
        // Given
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 looses 1 life points")
    }
    
    func test_LooseHealth_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .shoot(["p1"], .bang, .byPlayer("px")))
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerLooseHealth("p1", 1, .byPlayer("px")),
            .setChallenge(nil)
        ])
    }
    
    func test_TriggerStartTurnChallenge_IfLoosingLifePointOnDynamiteExploded() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .startTurnDynamiteExploded)
        let sut = LooseLife(actorId: "p1", points: 3)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerLooseHealth("p1", 3, .byDynamite),
            .setChallenge(.startTurn)
        ])
    }
    
    func test_RemoveActorFromShootChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"], .gatling, .byPlayer("px")))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerLooseHealth("p1", 1, .byPlayer("px")),
            .setChallenge(.shoot(["p2", "p3"], .gatling, .byPlayer("px")))
        ])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"], .byPlayer("px")))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerLooseHealth("p1", 1, .byPlayer("px")),
            .setChallenge(.indians(["p2", "p3"], .byPlayer("px")))
        ])
    }
    
    func test_RemoveDuelChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"], .byPlayer("p2")))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerLooseHealth("p1", 1, .byPlayer("p2")),
            .setChallenge(nil)
        ])
    }
}

class LooseLifeRuleTests: XCTestCase {
    
    func test_CanLooseLife_IfChallengedByShoot() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"], .gatling, .byPlayer("px")))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 1)])
    }
    
    func test_CanLooseLife_IfChallengedByIndians() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2"], .byPlayer("px")))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 1)])
    }
    
    func test_CanLooseLife_IfChallengedByDuel() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"], .byPlayer("p2")))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 1)])
    }
    
    func test_CanLooseLife_IfChallengedByDynamiteExploded() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: .startTurnDynamiteExploded)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 3)])
    }
}
