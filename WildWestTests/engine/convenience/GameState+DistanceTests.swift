//
//  GameState+DistanceTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameState_DistanceTests: XCTestCase {

    func test_ReturnZero_IfCalculatingRangeToSelf() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let sut = MockGameStateProtocol().players(are: mockPlayer1)
        
        // When
        // Asserta
        XCTAssertEqual(sut.distance(from: "p1", to: "p1"), 0)
    }
    
    func test_ReturnLowestDistance_IfCalculatingRangeToOther() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5")
        let sut = MockGameStateProtocol().players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p1", to: "p2"), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3"), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4"), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5"), 1)
        
        XCTAssertEqual(sut.distance(from: "p2", to: "p1"), 1)
        XCTAssertEqual(sut.distance(from: "p2", to: "p3"), 1)
        XCTAssertEqual(sut.distance(from: "p2", to: "p4"), 2)
        XCTAssertEqual(sut.distance(from: "p2", to: "p5"), 2)
        
        XCTAssertEqual(sut.distance(from: "p3", to: "p1"), 2)
        XCTAssertEqual(sut.distance(from: "p3", to: "p2"), 1)
        XCTAssertEqual(sut.distance(from: "p3", to: "p4"), 1)
        XCTAssertEqual(sut.distance(from: "p3", to: "p5"), 2)
        
        XCTAssertEqual(sut.distance(from: "p4", to: "p1"), 2)
        XCTAssertEqual(sut.distance(from: "p4", to: "p2"), 2)
        XCTAssertEqual(sut.distance(from: "p4", to: "p3"), 1)
        XCTAssertEqual(sut.distance(from: "p4", to: "p5"), 1)
        
        XCTAssertEqual(sut.distance(from: "p5", to: "p1"), 1)
        XCTAssertEqual(sut.distance(from: "p5", to: "p2"), 2)
        XCTAssertEqual(sut.distance(from: "p5", to: "p3"), 2)
        XCTAssertEqual(sut.distance(from: "p5", to: "p4"), 1)
    }
    
    func test_ReduceRangeToOthers_IfPlayingScope() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.scope))
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5")
        let sut = MockGameStateProtocol().players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p1", to: "p2"), 0)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3"), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4"), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5"), 0)
        
        XCTAssertEqual(sut.distance(from: "p2", to: "p1"), 1)
        XCTAssertEqual(sut.distance(from: "p3", to: "p1"), 2)
        XCTAssertEqual(sut.distance(from: "p4", to: "p1"), 2)
        XCTAssertEqual(sut.distance(from: "p5", to: "p1"), 1)
    }
    
    func test_IncrementRangeFromOthers_IfPlayingMustang() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.mustang))
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5")
        let sut = MockGameStateProtocol().players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p2", to: "p1"), 2)
        XCTAssertEqual(sut.distance(from: "p3", to: "p1"), 3)
        XCTAssertEqual(sut.distance(from: "p4", to: "p1"), 3)
        XCTAssertEqual(sut.distance(from: "p5", to: "p1"), 2)
        
        XCTAssertEqual(sut.distance(from: "p1", to: "p2"), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3"), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4"), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5"), 1)
    }

}
