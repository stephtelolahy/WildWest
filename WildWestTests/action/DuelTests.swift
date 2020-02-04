//
//  DuelTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class DuelTests: XCTestCase {
    
    func test_DiscardDuelCard_IfPlayingDuel() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
        
        let sut = Duel(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
    }
    
    func test_TriggerDuelChallenge_IfPlayingDuel() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
        
        let sut = Duel(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(equal(to: .duel(["p2", "p1"])))
    }
}

class DuelRuleTests: XCTestCase {
    
    func test_CanPlayDuel_IfYourTurnAndOwnCard() {
        // Given
        let sut = DuelRule()
        let mockCard = MockCardProtocol()
            .named(.duel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        
        // When
        let actions = sut.match(with: mockState)
        
        // AssertXCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "duel")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [Duel], [
            Duel(actorId: "p1", cardId: "c1", targetId: "p2"),
            Duel(actorId: "p1", cardId: "c1", targetId: "p3")
        ])
        XCTAssertEqual(actions?[0].options.map { $0.description }, [
            "p1 plays c1 against p2",
            "p1 plays c1 against p3"])
    }
    
}
