//
//  PlayerComputedTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stéphano TELOLAHY on 10/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine

class PlayerComputedTests: XCTestCase {

    // MARK: - weapon

    func test_DefaultGurnRange_Is1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.weapon, 1)
    }

    func test_GunRange_IsInPlayCardAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().withDefault().abilities(are: ["weapon": 5]))
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.weapon, 5)
    }

    // MARK: - bangsPerTurn

    func test_DefaultBangsPerTurnIs1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.bangsPerTurn, 1)
    }

    func test_NoLimitOnBangsPerTurn_IfHavingAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .abilities(are: ["bangsPerTurn": 0])
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.bangsPerTurn, 0)
    }

    func test_NoLimitOnBangsPerTurn_IfPlayingCardWithAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().withDefault().abilities(are: ["bangsPerTurn": 0]))
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.bangsPerTurn, 0)
    }

    // MARK: - mustang

    func test_DefaultMustangCount_Is0() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.mustang, 0)
    }

    func test_HasAMustangAtAllTimes_IfHavingAbility() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(is: MockCardAttributesProtocol().mustang(is: 1))
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.mustang, 1)
    }

    func test_HasDoubleMustang_IfPlayingMustangAndHavingAbility() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(is: MockCardAttributesProtocol().mustang(is: 1))
            .playing(MockCardProtocol().withDefault().attributes(is: MockCardAttributesProtocol().mustang(is: 1)))
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.mustang, 2)
    }

    // MARK: - scope

    func test_DefaultScopeCount_Is0() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.scope, 0)
    }

    func test_HasAScopeAtAllTimes_IfHavingAbility() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .abilities(are: ["scope": 0])
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.scope, 1)
    }

    func test_HasDoubleScope_IfPlayingMustangAndHavingAbility() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .abilities(are: ["scope": 0])
            .playing(MockCardProtocol().withDefault().abilities(are: ["scope": 0]))
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.scope, 2)
    }

    // MARK: - bangsCancelable

    func test_DefaultNeededMissesToCancelBangIs1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.bangsCancelable, 1)
    }

    func test_NeededMissesToCancelBangIs12_IfHAvingAbility() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .abilities(are: ["bangsCancelable": 2])
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.bangsCancelable, 2)
    }

    // MARK: - flippedCards

    func test_DefaultFlippedCards_Is1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.flippedCards, 1)
    }

    func test_FlippedCards_IsAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .abilities(are: ["flippedCards": 2])
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.flippedCards, 2)
    }

    // MARK: - handLimit

    func test_DefaultHandLimit_IsHealth() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .health(is: 4)
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.handLimit, 4)
    }

    func test_HandLimit_IsAttribute() {
        // Given
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .health(is: 4)
            .abilities(are: ["handLimit": 10])
        let sut = GPlayer(mockPlayer)

        // When
        // Assert
        XCTAssertEqual(sut.handLimit, 10)
    }
}
