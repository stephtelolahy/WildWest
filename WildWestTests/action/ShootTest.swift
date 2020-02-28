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
    
    func test_ShootDescription() {
        // Given
        let sut = Bang(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 against p2")
    }
    
    func test_DiscardCardAndTriggerBangChallenge_IfPlayingBang() {
        // Given
        let mockState = MockGameStateProtocol()
        let sut = Bang(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(.shoot(["p2"], .bang))
        ])
    }
}

class ShootRuleTest: XCTestCase {
    
    func test_CanPlayShoot_IfYourTurnAndOwnCardAndOtherIsAtRangeOf1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .bangsPlayed(is: 0)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(1)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(0)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(5)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(1)
        }
        
        let sut = BangRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Bang], [
            Bang(actorId: "p1", cardId: "c1", targetId: "p2"),
            Bang(actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
    func test_CannotPlayShoot_IfYourTurnAndOwnCardAndOtherIsUnreachable() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .bangsPlayed(is: 0)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(2)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(3)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(1)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(0)
        }
        
        let sut = BangRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CanPlayShoot_IfOtherIsReachableUsingGunRange() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(4)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(3)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(5)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(0)
        }
        
        let sut = BangRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Bang], [
            Bang(actorId: "p1", cardId: "c1", targetId: "p2"),
            Bang(actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
    func test_CannotPlayShoot_IfReachedLimitPerTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
            .bangsPlayed(is: 1)
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(1)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(1)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(1)
        }
        
        let sut = BangRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
