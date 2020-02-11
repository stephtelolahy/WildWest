//
//  StagecoachTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// Stagecoach
/// “Draw two cards” from the top of the deck.
///
class StagecoachTests: XCTestCase {
    
    func test_stagecoachDescription() {
        // Given
        let sut = Stagecoach(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_Pull2Cards_IfPlayingStagecoach() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Stagecoach(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerPullCardFromDeck("p1"),
            .playerPullCardFromDeck("p1")])
    }   
}

class StagecoachRuleTests: XCTestCase {
    
    func test_CanPlayStagecoach_IfYourTurnAndOwnCard() {
        // Given
        let sut = StagecoachRule()
        let mockCard = MockCardProtocol()
            .named(.stagecoach)
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
        XCTAssertEqual(actions as? [Stagecoach], [Stagecoach(actorId: "p1", cardId: "c1")])
    }
}
