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
    
    func test_DiscardCard_IfPlayingGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: MockPlayerProtocol().identified(by: "p1"))
        
        let sut = GeneralStore(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
    }
    
    func test_SetChallengeToGeneralStoreAndSetChoosableCards_IfPlayingGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: MockPlayerProtocol().identified(by: "p3"),
                     MockPlayerProtocol().identified(by: "p4"),
                     MockPlayerProtocol().identified(by: "p1"),
                     MockPlayerProtocol().identified(by: "p2"))
        
        let sut = GeneralStore(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setupGeneralStore(count: 4)
        verify(mockState).setChallenge(equal(to: .generalStore(["p1", "p2", "p3", "p4"])))
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
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "generalStore")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [GeneralStore], [GeneralStore(actorId: "p1", cardId: "c1")])
        XCTAssertEqual(actions?[0].options[0].description, "p1 plays c1")
    }
}
