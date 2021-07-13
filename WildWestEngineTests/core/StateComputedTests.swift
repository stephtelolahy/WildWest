//
//  StateComputedTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stéphano TELOLAHY on 10/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine

class StateComputedTests: XCTestCase {

    // MARK: - Distance

    func test_ReturnZero_IfCalculatingRangeToSelf() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let sut = GState(mockState)
        
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
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4, mockPlayer5)
            .playOrder(is: "p1", "p2", "p3", "p4", "p5")
        let sut = GState(mockState)
        
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
        let sut = GState(mockState)
        
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
        let sut = GState(mockState)
        
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
        let sut = GState(mockState)
        
        // When
        // Assert
        XCTAssertEqual(sut.distance(from: "p1", to: "p2"), 1)
        XCTAssertEqual(sut.distance(from: "p1", to: "p3"), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p4"), 2)
        XCTAssertEqual(sut.distance(from: "p1", to: "p5"), 1)
    }

    // MARK: - Winner

    func test_OutlawWins_IfSheriffIsEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .renegade)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .deputy)
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p1", "p2", "p3")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertEqual(sut.winner, .outlaw)
    }

    func test_RenegateWins_IfIsLastAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .renegade)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertEqual(sut.winner, .renegade)
    }
    
    func test_OutlawWins_IfIsLastAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertEqual(sut.winner, .outlaw)
    }
    
    func test_OutlawWins_IfDeputyIsLastAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .deputy)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertEqual(sut.winner, .outlaw)
    }

    func test_SheriffWins_IfAllOutlawsAreEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .deputy)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertEqual(sut.winner, .sheriff)
    }

    func test_NoOutcome_IfSheriffAndOutlawsAreNotEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .renegade)
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p1", "p2", "p3")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertNil(sut.winner)
    }

    func test_NoOutcome_IfRenegadeAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .renegade)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertNil(sut.winner)
    }

    func test_NoOutcome_IfOutlawAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
        let sut = GState(mockState)

        // When
        // Assert
        XCTAssertNil(sut.winner)
    }
}
