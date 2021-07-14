//
//  WinnerTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 13/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class WinnerTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()

    func test_OutlawWins_IfSheriffIsEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .renegade)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .deputy)
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p1", "p2", "p3")

        // When
        // Assert
        XCTAssertEqual(sut.winner(in: mockState), .outlaw)
    }

    func test_RenegateWins_IfIsLastAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .renegade)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")

        // When
        // Assert
        XCTAssertEqual(sut.winner(in: mockState), .renegade)
    }
    
    func test_OutlawWins_IfIsLastAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")

        // When
        // Assert
        XCTAssertEqual(sut.winner(in: mockState), .outlaw)
    }
    
    func test_OutlawWins_IfDeputyIsLastAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .deputy)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")

        // When
        // Assert
        XCTAssertEqual(sut.winner(in: mockState), .outlaw)
    }

    func test_SheriffWins_IfAllOutlawsAreEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .deputy)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")

        // When
        // Assert
        XCTAssertEqual(sut.winner(in: mockState), .sheriff)
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

        // When
        // Assert
        XCTAssertNil(sut.winner(in: mockState))
    }

    func test_NoOutcome_IfRenegadeAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .renegade)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")

        // When
        // Assert
        XCTAssertNil(sut.winner(in: mockState))
    }

    func test_NoOutcome_IfOutlawAlive() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")

        // When
        // Assert
        XCTAssertNil(sut.winner(in: mockState))
    }
}
