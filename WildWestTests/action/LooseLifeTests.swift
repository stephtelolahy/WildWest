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
    
    func test_LooseLifePoint_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .shoot(["p1"]))
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerSetHealth("p1", 2),
            .setChallenge(nil)
        ])
    }
    
    func test_StartTurn_IfLoosingLifePointOnDynamiteExploded() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .dynamiteExplode("p1"))
        let sut = LooseLife(actorId: "p1", points: 3)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerSetHealth("p1", 1),
            .setChallenge(.startTurn)
        ])
    }
    
    func test_EliminateActor_IfLoosingLastLife() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: .shoot(["p1"]))
            .players(are: mockPlayer1, MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .eliminatePlayer("p1"),
            .setChallenge(nil)
        ])
    }
    
    func test_RemoveActorFromShootChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerSetHealth("p1", 2),
            .setChallenge(.shoot(["p2", "p3"]))
        ])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerSetHealth("p1", 2),
            .setChallenge(.indians(["p2", "p3"]))
        ])
    }
    
    func test_RemoveDuelChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerSetHealth("p1", 2),
            .setChallenge(nil)
        ])
    }
    
    func test_EndTurn_IfTurnPlayerIsEliminated() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 1),
                     MockPlayerProtocol().identified(by: "p2"),
                     MockPlayerProtocol().identified(by: "p3"))
        let sut = LooseLife(actorId: "p1", points: 1)
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .eliminatePlayer("p1"),
            .setTurn("p2"),
            .setChallenge(.startTurn)
        ])
    }
    
}

class LooseLifeRuleTests: XCTestCase {
    
    func test_CanLooseLife_IfChallengedByShoot() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"]))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 1)])
    }
    
    func test_CanLooseLife_IfChallengedByIndians() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2"]))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 1)])
    }
    
    func test_CanLooseLife_IfChallengedByDuel() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"]))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 1)])
    }
    
    func test_CanLooseLife_IfChallengedByDynamiteExplode() {
        // Given
        let sut = LooseLifeRule()
        let mockState = MockGameStateProtocol()
            .challenge(is: .dynamiteExplode("p1"))
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1", points: 3)])
    }
}
