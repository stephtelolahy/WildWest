//
//  IndiansExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class IndiansExecutorTests: XCTestCase {
    
    private let sut = IndiansExecutor()
    
    func test_DiscardCardAndSetChallengeToIndiansAllOtherPlayersRightDirection_IfPlayingIndians() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer4, mockPlayer1, mockPlayer2, mockPlayer3)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .indians)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.indians(["p2", "p3", "p4"], "p1"))])
    }
}
