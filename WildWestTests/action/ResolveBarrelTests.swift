//
//  ResolveBarrelTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Barrel
 The Barrel allows you to “draw!” when you are the target of a BANG!:
 - if you draw a Heart card, you are Missed! (just like if you
 played a Missed! card);
 - otherwise nothing happens.
 Example. You are the target of another player’s BANG! You
 have a Barrel in play: this card lets you “draw!” to cancel a
 BANG! and it is successful on a Heart. So, you flip the top card
 of the deck and put it on the discard pile:
 it’s a 4 of Hearts. The use of the Barrel
 is successful and cancels the BANG!
 If the flipped card were of a different
 suit, then the Barrel would have had no
 effect, but you could have still tried to cancel the BANG!
 with a Missed!.
 */
class ResolveBarrelTests: XCTestCase {
    
    func test_ResolveBarrelDescription() {
        // Given
        let sut = ResolveBarrel(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 resolves c1")
    }
    
    func test_ResolveShootChallenge_IfReturnHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .hearts)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let sut = ResolveBarrel(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .flipOverFirstDeckCard,
            .setChallenge(nil)
        ])
    }
    
    func test_DoNotResolveShootChallenge_IfReturnNonHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().identified(by: "c1").suit(is: .diamonds)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let sut = ResolveBarrel(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .flipOverFirstDeckCard
        ])
    }
}

class UseBarrelRuleTests: XCTestCase {
    
    func test_CanUseBarrel_IfIsTargetOfShootAndPlayingBarrel() {
        // Given
        let sut = UseBarrelRule()
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 0)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [ResolveBarrel], [ResolveBarrel(actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotResolvedBarrelTwice() {
        // Given
        let sut = UseBarrelRule()
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 1)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
}
