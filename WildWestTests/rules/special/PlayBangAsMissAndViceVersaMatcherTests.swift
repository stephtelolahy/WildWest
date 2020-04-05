//
//  PlayBangAsMissAndViceVersaMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest


class BangWithMissedMatcherTests: XCTestCase {
    
    private let sut = BangWithMissedMatcher()
    
    func test_CanBangWithMiss_IfHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.missed).identified(by: "c1"))
            .abilities(are: [.canPlayBangAsMissAndViceVersa: true])
            .withDefault()
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2").withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .bangWithMissed, actorId: "p1", cardId: "c1", targetId: "p2")
        ])
    }
    
    func test_DiscardCardAndTriggerBangChallenge_IfPlayingBangWithMiss() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .bangWithMissed, actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(Challenge(name: .bang, targetIds: ["p2"], barrelsResolved: 0))])
    }
    
}

class MissWithBangMatcherTests: XCTestCase {
    
    private let sut = MissWithBangMatcher()
    
    func test_CanDiscardBang_IfIsTargetOfBangAndHanvingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.canPlayBangAsMissAndViceVersa: true])
            .holding(MockCardProtocol().identified(by: "c1").named(.bang))
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardId: "c1")])
    }
    
    func test_CanPlayBnag_IfIsTargetOfGatlingAndHanvingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.canPlayBangAsMissAndViceVersa: true])
            .holding(MockCardProtocol().identified(by: "c1").named(.bang))
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2", "p3"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardId: "c1")])
    }
}
