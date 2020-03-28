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
            .ability(is: .bartCassidy)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").noCardsInPlay(),
                     MockPlayerProtocol().identified(by: "p3").noCardsInPlay())
            .bangsPlayed(is: 0)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p2"),
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p3")
        ])
    }
    
    func test_CannotPlayBang_IfYourTurnAndOwnCardAndOtherIsUnreachable() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .noCardsInPlay()
            .ability(is: .bartCassidy)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").playing(MockCardProtocol().named(.mustang)),
                     MockPlayerProtocol().identified(by: "p3").playing(MockCardProtocol().named(.mustang)))
            .bangsPlayed(is: 0)
        
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
            .ability(is: .bartCassidy)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").playing(MockCardProtocol().named(.mustang)),
                     MockPlayerProtocol().identified(by: "p3").playing(MockCardProtocol().named(.mustang)))
            .bangsPlayed(is: 0)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p2"),
                               GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p3")])
    }
    
    func test_CannotPlayShoot_IfReachedLimitPerTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
            .noCardsInPlay()
            .ability(is: .bartCassidy)
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
            .bangsPlayed(is: 1)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_DiscardCardAndTriggerBangChallenge_IfPlayingBang() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.shoot(["p2"], .bang, "p1"))])
    }
}
