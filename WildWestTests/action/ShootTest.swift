//
//  ShootTest.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 BANG! cards are the main method to reduce other players’
 life points. If you want to play a BANG! card to hit one of the
 players, determine:
 a) what the distance to that player is; and
 b) if your weapon is capable of reaching that distance.
 Example 1. With reference to the distance figure, let us
 suppose that Ann (A) wants to shoot Carl (C), i.e. Ann wants
 to play a BANG! card against Carl. Usually Carl would be at
 a distance of 2, therefore Ann would need a weapon to shoot
 at this distance: a Schofield, a Remington, a Rev. Carabine
 or a Winchester, but not a Volcanic or the ol’ Colt .45. If Ann has a Scope in
 play, she would see Carl at a distance of 1, and therefore she could use any
 weapon to shoot at him. But if Carl has a Mustang in play, then the two cards
 would combine and Ann would still see Carl at a distance of 2.
 Example 2. If Dan (D) has a Mustang in play, Ann would see him at a distance
 of 4: in order to shoot Dan, Ann would need a weapon capable of reaching
 distance 4.
 */

class ShootTest: XCTestCase {
    
    func test_DiscardBangCard_IfPlayingShoot() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
        
        let sut = Shoot(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
    }
    
    func test_TriggerBangChallenge_IfShooting() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
        
        let sut = Shoot(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(equal(to: .shoot(["p2"])))
    }
    
    func test_IncrementShootsCount_IfShooting() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .turnShoots(is: 1)
        
        let sut = Shoot(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setTurnShoots(2)
    }
}

class ShootRuleTest: XCTestCase {
    
    func test_CanPlayShoot_IfYourTurnAndOwnCardAndOtherIsReachableByDefault() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.shoot).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .turnShoots(is: 0)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(1)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(0)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(5)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(1)
        }
        
        let sut = ShootRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Shoot], [
            Shoot(actorId: "p1", cardId: "c1", targetId: "p2"),
            Shoot(actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
    func test_CannotPlayShoot_IfYourTurnAndOwnCardAndOtherIsUnreachable() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.shoot).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .turnShoots(is: 0)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(2)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(3)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(1)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(0)
        }
        
        let sut = ShootRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertTrue(actions.isEmpty)
    }
    
    func test_CanPlayShoot_IfOtherIsReachableUsingGunRange() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.shoot).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(4)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(3)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(5)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(0)
        }
        
        let sut = ShootRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Shoot], [
            Shoot(actorId: "p1", cardId: "c1", targetId: "p2"),
            Shoot(actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
    func test_CannotPlayShoot_IfReachedLimitPerTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.shoot).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2)
            .turnShoots(is: 1)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(1)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(1)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(1)
        }
        
        let sut = ShootRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertTrue(actions.isEmpty)
    }
    
}
