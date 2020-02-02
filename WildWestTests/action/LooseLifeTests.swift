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
    
    func test_LooseLifePoint_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .shoot(["p1"]))
            .players(are: mockPlayer1, MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).looseLifePoint(playerId: "p1")
    }
    
    func test_EliminateActor_IfLoosingLastLife() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .shoot(["p1"]))
            .players(are: mockPlayer1, MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).eliminate(playerId: "p1")
    }
    
    func test_RemoveChallenge_IfLoosingLidePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .shoot(["p1"]))
            .players(are: mockPlayer1, MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(isNil())
    }
    
    func test_RemoveActorFromChallenge_IfLoosingLifePoint() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .shoot(["p1", "p2", "p3"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let sut = LooseLife(actorId: "p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(equal(to: .shoot(["p2", "p3"])))
    }
}

class LooseLifeRuleTests: XCTestCase {
    
    func test_CanLooseLife_IfChallengedByShoot() {
        // Given
        let sut = LooseLifeRule()
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [LooseLife], [LooseLife(actorId: "p1")])
    }
}
