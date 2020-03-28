//
//  RangeCalculatorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Weapons
 You start the game with a Colt .45 revolver. This is not
 represented by any card, but it is drawn on your playing board.
 Using the Colt .45 you can only hit targets at a distance of 1,
 i.e. only players sitting to your right or your left.
 In order to hit targets farther than distance 1, you need to
 play a bigger weapon: place it over the Colt .45. Weapons can
 be recognized from their blue border with no
 bullet holes, black-and-white illustration and the number
 into the sight (see picture) that represents the maximum
 reachable distance. The weapon in play substitutes the Colt
 .45, until the card is removed somehow. Even if weapons are
 played on the board, they can still be stolen (e.g. through
 the play of a Panic!) or discarded (e.g. through Cat Balou).
 The only weapon you can never lose is the ol’ Colt .45!
 You can only have one weapon in play at a time: if you
 want to play a new weapon when you already have one, you
 must discard the one you already have.
 Important: weapons do not change the distance between
 players. They represent your maximum reachable distance
 when shooting.
 Volcanic: with this card in play you may play any number
 of BANG! cards during your turn. These BANG! cards can
 be aimed at the same or different targets, but are limited to
 a distance of 1.
 */
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
        // Asserta
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
