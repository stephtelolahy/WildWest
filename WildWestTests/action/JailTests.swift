//
//  JailTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Jail
 Play this card in front of any player regardless of the distance:
 you put him in jail! If you are in jail, you must “draw!” before
 the beginning of your turn:
 - if you draw a Heart card, you escape from jail: discard the
 Jail, and continue your turn as normal;
 - otherwise discard the Jail and skip your turn.
 If you are in Jail you remain a possible target for BANG!
 cards and can still play response cards (e.g. Missed! and
 Beer) out of your turn, if necessary.
 Jail cannot be played on the Sheriff.
 */
class JailTests: XCTestCase {
    
    func test_JailDescription() {
        // Given
        let sut = Jail(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 put p2 in jail")
    }
    
    func test_PutCardInPlayOfTargetPlayer_IfPlayingJail() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Jail(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [.playerPutInPlayOfOther("p1", "p2", "c1")])
    }
}

class JailRuleTests: XCTestCase {
    
    func test_CanPlayJail_IfHoldingCardAndAgainsNonSheriffPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.jail))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .outlaw)
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let sut = JailRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Jail], [Jail(actorId: "p1", cardId: "c1", targetId: "p2")])
    }
    
    func test_CannotPlayJail_IfTargetPlayerIsSheriff() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.jail))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let sut = JailRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CannotPlayJail_IfTargetPlayerIsAlreadyInJail() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.jail))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .deputy)
            .playing(MockCardProtocol().named(.jail))
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let sut = JailRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
