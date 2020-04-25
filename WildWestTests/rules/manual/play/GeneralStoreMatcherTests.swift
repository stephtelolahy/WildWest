//
//  GeneralStoreMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GeneralStoreMatcherTests: XCTestCase {
    
    private let sut = GeneralStoreMatcher()
    
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
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves,  [GameMove(name: .generalStore, actorId: "p1", cardId: "c1")])
    }
    
    func test_SetChallengeToGeneralStoreAndSetChoosableCards_IfPlayingGeneralStore() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
            .holding(MockCardProtocol().named(.generalStore).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
        
        let move = GameMove(name: .generalStore, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .generalStore, targetIds: ["p1", "p2", "p3", "p4"])),
                                 .setupGeneralStore(4),
                                 .playerDiscardHand("p1", "c1")])
    }
}
