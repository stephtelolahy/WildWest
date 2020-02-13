//
//  GeneralStoreTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 General store
 When you play this card,
 turn as many cards from the
 deck face up as the players
 still playing. Starting
 with you and proceeding
 clockwise, each player
 chooses one of those cards
 and puts it in his hands
 */
class GeneralStoreTests: XCTestCase {
    
    func test_GeneralStoreDescription() {
        // Given
        let sut = GeneralStore(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_SetChallengeToGeneralStoreAndSetChoosableCards_IfPlayingGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p3"),
                     MockPlayerProtocol().identified(by: "p4"),
                     MockPlayerProtocol().identified(by: "p1"),
                     MockPlayerProtocol().identified(by: "p2"))
        
        let sut = GeneralStore(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setupGeneralStore(4),
            .setChallenge(.generalStore(["p1", "p2", "p3", "p4"]))
        ])
    }
}

class GeneralStoreRuleTests: XCTestCase {
    
    func test_CanPlayGeneralStore_IfYourTurnAndOwnCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.generalStore)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1)
        let sut = GeneralStoreRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [GeneralStore],  [GeneralStore(actorId: "p1", cardId: "c1")])
    }
}
