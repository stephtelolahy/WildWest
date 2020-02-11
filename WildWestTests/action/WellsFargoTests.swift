//
//  WellsFargoTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// WellsFargo
/// “Draw three cards” from the top of the deck.
///
class WellsFargoTests: XCTestCase {
    
    func test_wellsFargoDescription() {
        // Given
        let sut = Stagecoach(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_Pull3Cards_IfPlayingWellsFargo() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = WellsFargo(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerPullFromDeck("p1"),
            .playerPullFromDeck("p1"),
            .playerPullFromDeck("p1")])
    }
}

class WellsFargoRuleTests: XCTestCase {
    
    func test_CanPlayWellsFargo_IfYourTurnAndOwnCard() {
        // Given
        let sut = WellsFargoRule()
        let mockCard = MockCardProtocol()
            .named(.wellsFargo)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [WellsFargo], [WellsFargo(actorId: "p1", cardId: "c1")])
    }
}
