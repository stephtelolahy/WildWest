//
//  GameMoveExtensionTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameMoveExtensionTests: XCTestCase {
    
    func test_GroupingMovesByActor() {
        // Given
        let moves = [GameMove(name: .play, actorId: "p1"),
                     GameMove(name: .endTurn, actorId: "p1")]
        
        // When
        let grouped = moves.groupedByActor()
        
        // Assert
        XCTAssertEqual(grouped, ["p1": [GameMove(name: .play, actorId: "p1"),
                                        GameMove(name: .endTurn, actorId: "p1")]])
    }
}
