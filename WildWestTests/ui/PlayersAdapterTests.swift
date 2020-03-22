//
//  PlayersAdapterTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PlayersAdapterTests: XCTestCase {
    
    private let sut = PlayersAdapter()
    
    func test_BuildIndexesFor1Players() {
        // Given
        let playerIds = ["a"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a"])
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: "a"), [7: "a"])
    }
    
    func test_BuildIndexesFor2Players() {
        // Given
        let playerIds = ["a", "b"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a", 1: "b"])
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: "a"), [7: "a", 1: "b"])
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: "b"), [7: "b", 1: "a"])
    }
    
    func test_BuildIndexesFor3Players() {
        // Given
        let playerIds = ["a", "b", "c"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a", 0: "b", 2: "c"])
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: "a"), [7: "a", 0: "b", 2: "c"])
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: "b"), [7: "b", 0: "c", 2: "a"])
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: "c"), [7: "c", 0: "a", 2: "b"])
    }
    
    func test_BuildIndexesFor4Players() {
        // Given
        let playerIds = ["a", "b", "c", "d"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a", 3: "b", 1: "c", 5: "d"])
    }
    
    func test_BuildIndexesFor5Players() {
        // Given
        let playerIds = ["a", "b", "c", "d", "e"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a", 3: "b", 0: "c", 2: "d", 5: "e"])
        
    }
    
    func test_BuildIndexesFor6Players() {
        // Given
        let playerIds = ["a", "b", "c", "d", "e", "f"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a", 3: "b", 0: "c", 1: "d", 2: "e", 5: "f"])
    }
    
    func test_BuildIndexesFor7Players() {
        // Given
        let playerIds = ["a", "b", "c", "d", "e", "f", "g"]
        
        // When
        // Assert
        XCTAssertEqual(sut.buildIndexes(playerIds: playerIds, controlledId: nil), [7: "a", 6: "b", 3: "c", 0: "d", 1: "e", 2: "f", 5: "g"])
    }
}
