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
    
    func test_Pull2Cards_IfPlayingStagecoach() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Stagecoach(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState, times(2)).pullFromDeck(playerId: "p1")
        verifyNoMoreInteractions(mockState)
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
            .currentTurn(is: 0)
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "stagecoach")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [Stagecoach], [Stagecoach(actorId: "p1", cardId: "c1")])
        XCTAssertEqual(actions?[0].options[0].description, "p1 plays c1")
    }
}
