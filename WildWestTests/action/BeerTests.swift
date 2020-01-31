//
//  BeerTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// Beer
/// This card lets you regain one life point – take a bullet from the pile.
/// You cannot gain more life points than your starting amount! The Beer cannot be used to help other players.
/// The Beer can be played in two ways:
/// - as usual, during your turn;
/// - out of turn, but only if you have just
/// received a hit that is lethal (i.e. a hit that takes away your last life point),
/// and not if you are simply hit.
/// Beer has no effect if there are only 2 players left in the game;
/// in other words, if you play a Beer you do not gain any life point.
///
class BeerTests: XCTestCase {
    
    func test_GainLifePoint_IfPlayingBeer() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Beer(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(state: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).gainLifePoint(playerId: "p1")
        verifyNoMoreInteractions(mockState)
    }
    
    func test_CanPlayBeer_IfYourTurnAndOwnCard() {
        // Given
        let sut = BeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(state: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Beer], [Beer(actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotPlayBeer_ToGainMoreLifePointsThanYourStartingAmount() {
        // Given
        let sut = BeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .health(is: 4)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(state: mockState)
        
        // Assert
        XCTAssertTrue(actions.isEmpty)
    }
    
    func test_CannotPlayBeer_IfThereAreOnly2PlayersLeft() {
        // Given
        let sut = BeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer, MockPlayerProtocol())
        
        // When
        let actions = sut.match(state: mockState)
        
        // Assert
        XCTAssertTrue(actions.isEmpty)
    }
}
