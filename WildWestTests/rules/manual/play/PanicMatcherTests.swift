//
//  PanicMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class PanicMatcherTests: XCTestCase {
    
    private let sut = PanicMatcher()
    
    func test_CanPlayPanic_IfYourTurnAndOwnCardAndDistanceIs1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
            .withDefault()
        
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
            .withDefault()
        
        let mockPlayer3 = MockPlayerProtocol()
            .identified(by: "p3")
            .playing(MockCardProtocol().identified(by: "c3").named(.volcanic))
            .withDefault()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name:.play, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p2", source: .randomHand)),
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p3", source: .inPlay("c3")))
        ])
    }
    
    func test_CannotPlayPanic_IfTargetPlayerDistanceIsGreaterThan1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
            .withDefault()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1,
                     MockPlayerProtocol().identified(by: "p2").withDefault(),
                     MockPlayerProtocol().identified(by: "p3").holding(MockCardProtocol()).withDefault(),
                     MockPlayerProtocol().identified(by: "p4").withDefault())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotPlayPanic_IfNoCardsToDiscard() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
            .noCardsInPlay()
        
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .noCardsInHand()
            .noCardsInPlay()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_PullOtherPlayerHandCard_IfPlayingPanic() {
        // Given
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer2)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p2", source: .randomHand))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromOtherHand("p1", "p2", "c2")])
    }
    
    func test_PullOtherPlayerInPlayCard_IfPlayingPanic() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromOtherInPlay("p1", "p2", "c2")])
    }
}
