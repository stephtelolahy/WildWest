//
//  RangeCalculatorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class RangeCalculatorTests: XCTestCase {
    
    override func setUp() {
        DefaultValueRegistry.register(value: [CardProtocol](), forType: [CardProtocol].self)
    }
    
    func test_ReturnZero_IfCalculatingRangeToSelf() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockState = MockGameStateProtocol().players(are: mockPlayer1)
        let sut = RangeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p1", to: "p1", in: mockState), 0)
    }
    
    func test_ReturnLowestDistance_IfCalculatingRangeToOther() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p5")
        let mockState = MockGameStateProtocol().players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
        let sut = RangeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p1", to: "p2", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5", in: mockState), 1)
        
        XCTAssertEqual(sut.distance(from: "p2", to: "p1", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p2", to: "p3", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p2", to: "p4", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p2", to: "p5", in: mockState), 2)
        
        XCTAssertEqual(sut.distance(from: "p3", to: "p1", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p3", to: "p2", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p3", to: "p4", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p3", to: "p5", in: mockState), 2)
        
        XCTAssertEqual(sut.distance(from: "p4", to: "p1", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p4", to: "p2", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p4", to: "p3", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p4", to: "p5", in: mockState), 1)
        
        XCTAssertEqual(sut.distance(from: "p5", to: "p1", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p5", to: "p2", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p5", to: "p3", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p5", to: "p4", in: mockState), 1)
    }
    
    func test_ReduceRangeToOthers_IfPlayingScope() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.scope))
        let mockPlayer2 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p5")
        let mockState = MockGameStateProtocol().players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
        let sut = RangeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p1", to: "p2", in: mockState), 0)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5", in: mockState), 0)
        
        XCTAssertEqual(sut.distance(from: "p2", to: "p1", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p3", to: "p1", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p4", to: "p1", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p5", to: "p1", in: mockState), 1)
    }
    
    func test_IncrementRangeFromOthers_IfPlayingMustang() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.mustang))
        let mockPlayer2 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4")
        let mockPlayer5 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p5")
        let mockState = MockGameStateProtocol().players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
        let sut = RangeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p2", to: "p1", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p3", to: "p1", in: mockState), 3)
        XCTAssertEqual(sut.distance(from: "p4", to: "p1", in: mockState), 3)
        XCTAssertEqual(sut.distance(from: "p5", to: "p1", in: mockState), 2)
        
        XCTAssertEqual(sut.distance(from: "p1", to: "p2", in: mockState), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4", in: mockState), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5", in: mockState), 1)
    }
}
