//
//  ResolveDynamiteTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Dynamite
 Play this card in front of you: the Dynamite will stay there for a whole turn.
 When you start your next turn (you have the Dynamite already in play),
 before the first phase you must “draw!”:
 - if you draw a card showing Spades and a number between 2 and 9, the
 Dynamite explodes! Discard it and lose 3 life points;
 - otherwise, pass the Dynamite to the player on your left
 (who will “draw!” on his turn, etc.).
 Players keep passing the Dynamite around until it explodes,
 with the effect explained above, or it is drawn or discarded by a
 Panic! or a Cat Balou. If you have both the Dynamite and a Jail
 in play, check the Dynamite first. If you are damaged (or even
 eliminated!) by a Dynamite, this damage is not considered to
 be caused by any player
 */
class ResolveDynamiteTests: XCTestCase {
    
    func test_ResolveDynamiteDescription() {
        // Given
        let sut = ResolveDynamite(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 resolves c1")
    }
    
    func test_PassDynamite_IfDoesNotExplode() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .diamonds)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
            when(mock.turn.get).thenReturn("p1")
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().identified(by: "p1"),
                MockPlayerProtocol().identified(by: "p2")
            ])
        }
        
        let sut = ResolveDynamite(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .flipOverFirstDeckCard,
            .playerPassInPlayOfOther("p1", "p2", "c1")
        ])
    }
    
    func test_DiscardDynamiteAndSetExplodeChallenge_IfExplodes() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .spades).value(is: "3")
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
        }
        
        let sut = ResolveDynamite(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .flipOverFirstDeckCard,
            .setChallenge(.dynamiteExplode("p1")),
            .playerDiscardInPlay("p1", "c1")
        ])
    }
}

class ResolveDynamiteRuleTests: XCTestCase {
    
    func test_ShouldResolveDynamite_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .startTurn)
            .currentTurn(is: "p1")
        let sut = ResolveDynamiteRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // assert
        XCTAssertEqual(actions as? [ResolveDynamite], [ResolveDynamite(actorId: "p1", cardId: "c1")])
    }
    
    func test_ShouldResolveDynamite_BeforeResolvingJail() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"),
                     MockCardProtocol().named(.jail).identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .startTurn)
            .currentTurn(is: "p1")
        let sut = ResolveDynamiteRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // assert
        XCTAssertEqual(actions as? [ResolveDynamite], [ResolveDynamite(actorId: "p1", cardId: "c1")])
    }
}
