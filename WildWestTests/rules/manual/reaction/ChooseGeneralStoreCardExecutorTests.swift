//
//  ChooseGeneralStoreCardExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ChooseGeneralStoreCardExecutorTests: XCTestCase {
    
    private let sut = ChooseGeneralStoreCardExecutor()
    
    func test_PickOneCardFromGeneralStore_IfChoosingCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1", "p2"]))
        let move = GameMove(name: .choose, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromGeneralStore("p1", "c1"),
                                 .setChallenge(.generalStore(["p2"]))])
    }
    
    func test_RemoveChallenge_IfChoosingLastCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1"]))
        let move = GameMove(name: .choose, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromGeneralStore("p1", "c1"),
                                 .setChallenge(nil)])
    }
}
