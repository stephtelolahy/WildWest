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
        XCTAssertEqual(moves,  [GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .generalStore)])
    }
    
    func test_SetChallengeToGeneralStoreAndSetChoosableCards_IfPlayingGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p3"),
                     MockPlayerProtocol().identified(by: "p4"),
                     MockPlayerProtocol().identified(by: "p1"),
                     MockPlayerProtocol().identified(by: "p2"))
        
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .generalStore)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setupGeneralStore(4),
                                 .setChallenge(Challenge(name: .generalStore, actorId: "p1", targetIds: ["p1", "p2", "p3", "p4"]))])
    }
}
