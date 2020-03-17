//
//  GameMoveExtensionTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameMoveExtensionTests: XCTestCase {

    func test_MergingGameMoves() {
        // Given
        let moves: [[String: [GameMove]]] = [
            ["p1": [.startTurn(actorId: "p1")]],
            ["p1": [.startTurn(actorId: "p1")]]
        ]
        
        // When
        let merged = moves.merged()
        
        // Assert
        XCTAssertEqual(merged, ["p1": [.startTurn(actorId: "p1"), .startTurn(actorId: "p1")]])
    }
}
