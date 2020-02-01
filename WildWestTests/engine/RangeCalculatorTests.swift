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
    
    private let sut = RangeCalculator()
    
    override func setUp() {
        DefaultValueRegistry.register(value: [CardProtocol](), forType: [CardProtocol].self)
    }
    
    func test_ReturnZero_IfCalculatingRangeToSelf() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockState = MockGameStateProtocol().players(are: mockPlayer1)
        
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
    
    func test_ReachableDistanceOfDefaultGunIs1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub())
        
        // When
        // Assert
        XCTAssertEqual(sut.reachableDistance(of: mockPlayer), 1)
    }
    
    func test_ReachableDistanceOfVolcanicIs1() {
        // Given
        let mockPlayer = MockPlayerProtocol().playing(MockCardProtocol().named(.volcanic))
        
        // When
        // Assert
        XCTAssertEqual(sut.reachableDistance(of: mockPlayer), 1)
    }
    
    func test_ReachableDistanceOfSchofieldIs2() {
        // Given
        let mockPlayer = MockPlayerProtocol().playing(MockCardProtocol().named(.schofield))
        
        // When
        // Assert
        XCTAssertEqual(sut.reachableDistance(of: mockPlayer), 2)
    }
    
    func test_ReachableDistanceOfRemingtonIs3() {
        // Given
        let mockPlayer = MockPlayerProtocol().playing(MockCardProtocol().named(.remington))
        
        // When
        // Assert
        XCTAssertEqual(sut.reachableDistance(of: mockPlayer), 3)
    }
    
    func test_ReachableDistanceOfCarabineIs4() {
        // Given
        let mockPlayer = MockPlayerProtocol().playing(MockCardProtocol().named(.revCarbine))
        
        // When
        // Assert
        XCTAssertEqual(sut.reachableDistance(of: mockPlayer), 4)
    }
    
    func test_ReachableDistanceOfWinchesterIs5() {
        // Given
        let mockPlayer = MockPlayerProtocol().playing(MockCardProtocol().named(.winchester))
        
        // When
        // Assert
        XCTAssertEqual(sut.reachableDistance(of: mockPlayer), 5)
    }
}
