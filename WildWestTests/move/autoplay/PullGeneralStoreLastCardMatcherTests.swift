//
//  PullGeneralStoreLastCardMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class PullGeneralStoreLastCardMatcherTests: XCTestCase {

    private let sut = PullGeneralStoreLastCardMatcher()

    func test_AutomaticallyPullLastCard_IfChallengeIsGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1"]))
            .players(are: MockPlayerProtocol().identified(by: "p1"))
        Cuckoo.stub(mockState) { mock in
            let card1 = MockCardProtocol().identified(by: "c1")
            when(mock.generalStore.get).thenReturn([card1])
        }
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .choose, actorId: "p1", cardId: "c1")])
    }
}
