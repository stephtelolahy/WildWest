//
//  GeneralStoreExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GeneralStoreExecutorTests: XCTestCase {
    
    private let sut = GeneralStoreExecutor()
    
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
                                 .setChallenge(.generalStore(["p1", "p2", "p3", "p4"]))])
    }
}
