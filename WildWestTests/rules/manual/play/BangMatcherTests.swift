//
//  BangMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class BangMatcherTests: XCTestCase {
    
    private let sut = BangMatcher()
    
    func test_CanPlayBang_IfYourTurnAndOwnCardAndOtherIsAtRangeOf1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .playing(MockCardProtocol().named(.winchester))
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").withDefault(),
                     MockPlayerProtocol().identified(by: "p3").withDefault())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .bang, actorId: "p1", cardId: "c1", targetId: "p2"),
            GameMove(name: .bang, actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
    func test_CannotPlayBang_IfYourTurnAndOwnCardAndOtherIsUnreachable() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").playing(MockCardProtocol().named(.mustang)).withDefault(),
                     MockPlayerProtocol().identified(by: "p3").playing(MockCardProtocol().named(.mustang)).withDefault())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CanPlayBang_IfOtherIsReachableUsingGunRange() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .playing(MockCardProtocol().named(.winchester))
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").playing(MockCardProtocol().named(.mustang)).withDefault(),
                     MockPlayerProtocol().identified(by: "p3").playing(MockCardProtocol().named(.mustang)).withDefault())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .bang, actorId: "p1", cardId: "c1", targetId: "p2"),
                               GameMove(name: .bang, actorId: "p1", cardId: "c1", targetId: "p3")])
    }
    
    func test_CannotPlayShoot_IfReachedLimitPerTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .bangsPlayed(is: 1)
            .withDefault()
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_DiscardCardAndTriggerBangChallenge_IfPlayingBang() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .withDefault()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .bang, actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(Challenge(name: .bang, targetIds: ["p2"], counterNeeded: 1, barrelsResolved: 0))])
    }
    
    func test_Need2MissesToCancelHisBang_IfPlayingBangAndHAvingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .abilities(are: [.othersNeed2MissesToCounterHisBang: true])
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .bang, actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(Challenge(name: .bang, targetIds: ["p2"], counterNeeded: 2, barrelsResolved: 0))])
    }
}
