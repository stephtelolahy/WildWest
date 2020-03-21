//
//  DynamiteExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DynamiteExecutorTests: XCTestCase {

    private let sut = DynamiteExecutor()

    func test_PutCardInPlay_IfEquipping() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.dynamite))
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .dynamite)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPutInPlay("p1", "c1")])
    }
}
