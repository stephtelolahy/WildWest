//
//  DistanceTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 14/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine

class DistanceTests: XCTestCase {
    
    func test_ReturnZero_IfCalculatingRangeToSelf() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        
        // When
        // Asserta
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p1", in: mockState), 0)
    }
    
    func test_ReturnLowestDistance_IfCalculatingRangeToOther() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
            .playOrder(is: "p1", "p2", "p3", "p4", "p5")
        
        // When
        // Assert
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p2", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p3", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p4", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p5", in: mockState), 1)
        
        XCTAssertEqual(DistanceRules.distance(from: "p2", to: "p1", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p2", to: "p3", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p2", to: "p4", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p2", to: "p5", in: mockState), 2)
        
        XCTAssertEqual(DistanceRules.distance(from: "p3", to: "p1", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p3", to: "p2", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p3", to: "p4", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p3", to: "p5", in: mockState), 2)
        
        XCTAssertEqual(DistanceRules.distance(from: "p4", to: "p1", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p4", to: "p2", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p4", to: "p3", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p4", to: "p5", in: mockState), 1)
        
        XCTAssertEqual(DistanceRules.distance(from: "p5", to: "p1", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p5", to: "p2", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p5", to: "p3", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p5", to: "p4", in: mockState), 1)
    }
    
    func test_DecrementDistanceToOthers_IfHavingScope() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .attributes(are: [.scope: 1])
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
            .playOrder(is: "p1", "p2", "p3", "p4", "p5")
        
        // When
        // Assert
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p2", in: mockState), 0)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p3", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p4", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p5", in: mockState), 0)
        
        XCTAssertEqual(DistanceRules.distance(from: "p2", to: "p1", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p3", to: "p1", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p4", to: "p1", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p5", to: "p1", in: mockState), 1)
    }
    
    func test_IncrementDistanceFromOthers_IfHavingMustang() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .attributes(are: [.mustang: 1])
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
            .playOrder(is: "p1", "p2", "p3", "p4", "p5")
        
        // When
        // Assert
        XCTAssertEqual(DistanceRules.distance(from: "p2", to: "p1", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p3", to: "p1", in: mockState), 3)
        XCTAssertEqual(DistanceRules.distance(from: "p4", to: "p1", in: mockState), 3)
        XCTAssertEqual(DistanceRules.distance(from: "p5", to: "p1", in: mockState), 2)
        
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p2", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p3", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p4", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p5", in: mockState), 1)
    }
    
    func test_DisableOthersMustang_IfHavingAttributeSilentInPlayAndYourTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").attributes(are: [.silentInPlay: true])
        let mustang = MockCardProtocol().withDefault().attributes(are: [.mustang: 1])
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").playing(mustang)
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3").playing(mustang)
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4").playing(mustang)
        let mockPlayer5 = MockPlayerProtocol().withDefault().identified(by: "p5").playing(mustang)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
            .playOrder(is: "p1", "p2", "p3", "p4", "p5")
            .turn(is: "p1")
        
        // When
        // Assert
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p2", in: mockState), 1)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p3", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p4", in: mockState), 2)
        XCTAssertEqual(DistanceRules.distance(from: "p1", to: "p5", in: mockState), 1)
    }
}
