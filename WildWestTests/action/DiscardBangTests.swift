//
//  DiscardBangTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class DiscardBangTests: XCTestCase {
    
    func test_DiscardCard_IfDiscardingBang() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .indians(["p1", "p2", "p3"]))
        let sut = DiscardBang(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
    }
    
    func test_RemoveActorFromIndiansChallenge_IfDiscardingBang() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .indians(["p1", "p2", "p3"]))
        let sut = DiscardBang(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(equal(to: .indians(["p2", "p3"])))
    }
    
    func test_SwitchTargetOfDuelChallenge_IfDiscardingBang() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .duel(["p1", "p2"]))
        let sut = DiscardBang(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(equal(to: .duel(["p2", "p1"])))
    }
}

class DiscardBangRuleTests: XCTestCase {
    
    func test_CanDiscardBang_IfIsTargetOfIndiansAndHoldingBangCard() {
        // Given
        let sut = DiscardBangRule()
        let mockCard = MockCardProtocol()
            .named(.bang)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "discardBang")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [DiscardBang], [DiscardBang(actorId: "p1", cardId: "c1")])
        XCTAssertEqual(actions?[0].options[0].description, "p1 discards c1")
    }
    
    func test_CanDiscardBang_IfIsTargetOfDuelAndHoldingBangCard() {
        // Given
        let sut = DiscardBangRule()
        let mockCard = MockCardProtocol()
            .named(.bang)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "discardBang")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [DiscardBang], [DiscardBang(actorId: "p1", cardId: "c1")])
        XCTAssertEqual(actions?[0].options[0].description, "p1 discards c1")
    }
}
