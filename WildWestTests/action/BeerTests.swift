//
//  BeerTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Beer
 This card lets you regain
 one life point – take a bullet
 from the pile. You cannot
 gain more life points than
 your starting amount!
 The Beer cannot be used
 to help other players.
 The Beer can be played in
 two ways:
 •     as usual, during your
 turn;
 •     out of turn, but only if you have just
 received a hit that is lethal (i.e. a hit that takes away your last life point),
 and not if you are simply hit.
 Beer has no effect if there are only 2 players left in the game; in other words,
 if you play a Beer you do not gain any life point.
 Example. You have 2 life points left, and suffer 3 damages from a Dynamite.
 If you play 2 Beers you will stay alive with 1 life point left (2-3+2), while you
 would be eliminated playing only one Beer that would allow you to regain just
 1 life point. You would still be at zero!
 */
class BeerTests: XCTestCase {
    
    func test_BeerDescription() {
        // Given
        let sut = Beer(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    
    func test_GainLifePoint_IfPlayingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 3))
        let sut = Beer(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerSetHealth("p1", 4)
        ])
    }
}

class BeerRuleTests: XCTestCase {
    
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
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Beer], [Beer(actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotPlayBeer_IfMaxHealth() {
        // Given
        let sut = BeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard)
            .health(is: 4)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CannotPlayBeer_IfThereAreOnly2PlayersLeft() {
        // Given
        let sut = BeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
