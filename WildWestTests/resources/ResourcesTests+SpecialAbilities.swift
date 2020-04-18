//
//  ResourcesTests+SpecialAbilities.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class ResourcesTests_SpecialAbilities: XCTestCase {

    private lazy var figures: [FigureProtocol] = {
        let jsonReader = JsonReader(bundle: Bundle(for: type(of: self)))
        let sut = GameConfiguration(jsonReader: jsonReader)
        return sut.allFigures
    }()
    
    func test_WillyTheKidHasNoLimitOnBangsPerTurn() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .willyTheKid }))
        XCTAssertEqual(figure.abilities, [.hasNoLimitOnBangsPerTurn: true])
    }
    
    func test_JourdonaisHasABarrel_AtAllTimes() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .joudonais }))
        XCTAssertEqual(figure.abilities, [.hasBarrelAllTimes: true])
    }
    
    func test_RoseDolanHasAScope_AtAllTimes() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .roseDoolan }))
        XCTAssertEqual(figure.abilities, [.hasScopeAllTimes: true])
    }
    
    func test_PaulRegretHasAMustang_AtAllTimes() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .paulRegret }))
        XCTAssertEqual(figure.abilities, [.hasMustangAllTimes: true])
    }
    
    func test_BatCassidyDrawsACard_OnLoseHealth() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .bartCassidy }))
        XCTAssertEqual(figure.abilities, [.drawsCardOnLoseHealth: true])
    }
    
    func test_Elgringo_OnDrawsCardFromPlayerDamagedHim() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .elGringo }))
        XCTAssertEqual(figure.abilities, [.drawsCardFromPlayerDamagedHim: true])
    }
    
    func test_SuzzyLafayette_SrawsCardWhenHandIsEmpty() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .suzyLafayette }))
        XCTAssertEqual(figure.abilities, [.drawsCardWhenHandIsEmpty: true])
    }
    
    func test_CalamityJanet_CanPlayBangAsMissAndViceVersa() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .calamityJanet }))
        XCTAssertEqual(figure.abilities, [.canPlayBangAsMissAndViceVersa: true])
    }
    
    func test_BlackJack_DrawsAnotherCardIfSecondDrawIsRedSuit() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .blackJack }))
        XCTAssertEqual(figure.abilities, [.drawsAnotherCardIfSecondDrawIsRedSuit: true])
    }

    func test_StabTheKiller_OthersNeed2MissesToCounterHisBang() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .slabTheKiller }))
        XCTAssertEqual(figure.abilities, [.othersNeed2MissesToCounterHisBang: true])
    }
    
    func test_VultureSam_TakesAllCardsFromEliminatedPlayers() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .vultureSam }))
        XCTAssertEqual(figure.abilities, [.takesAllCardsFromEliminatedPlayers: true])
    }
    
    func test_LuckyDuke_Flips2CardsOnADrawAndChoose1() throws {
        // Given
        // When
        // Assert
        let figure = try XCTUnwrap(figures.first(where: { $0.name == .luckyDuke }))
        XCTAssertEqual(figure.abilities, [.flips2CardsOnADrawAndChoose1: true])
    }
}
