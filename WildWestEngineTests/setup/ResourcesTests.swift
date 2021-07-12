//
//  ResourcesTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class ResourcesTests: XCTestCase {
    
    private let sut: ResourcesLoaderProtocol = Resolver.resolve()
    
    func test_SciptedRulesAreMoreThanHardCodedRules() throws {
        // Given
        // When
        let coded = EffectFamily.allCases.count + PlayReqFamily.allCases.count
        let scripted = sut.loadAbilities().count
        
        // Assert
        XCTAssertTrue(scripted >= coded)
    }
    
    func test_AllAbilitiesHaveEffects() throws {
        // Given
        // When
        let abilities = sut.loadAbilities()
        
        // Assert
        XCTAssertNotNil(abilities)
        abilities.forEach {
            XCTAssertFalse($0.onPlay.isEmpty, "Empty effects for ability \($0.name)")
        }
    }
    
    func test_AllCardsHaveValidAbilities() throws {
        // Given
        let allAbilities = sut.loadAbilities().map { $0.name }
        
        // When
        let cards = sut.loadCards()
        
        // Assert
        cards.forEach { card in
            card.abilities.forEach {
                XCTAssertTrue(allAbilities.contains($0), "Invalid ability \($0) in card \(card.name)")
            }
        }
    }
    
    func test_DefaultPlayerAbilities() throws {
        // Given
        // When
        let card = sut.loadCards().first { $0.type == .default && $0.name == "player" }!
        
        // Assert
        XCTAssertTrue(card.abilities.contains("startTurnDrawing2Cards"))
        XCTAssertTrue(card.abilities.contains("endTurn"))
        XCTAssertTrue(card.abilities.contains("nextTurnOnPhase3"))
        XCTAssertTrue(card.abilities.contains("nextTurnOnEliminated"))
        XCTAssertTrue(card.abilities.contains("discardExcessCardsOnPhase3"))
        XCTAssertTrue(card.abilities.contains("discardAllCardsOnEliminated"))
        XCTAssertTrue(card.abilities.contains("gainRewardOnEliminatingOutlaw"))
    }
    
    func test_DefaultSheriffAbilities() throws {
        // Given
        // When
        let card = sut.loadCards().first { $0.type == .default && $0.name == "sheriff" }!
        
        // Assert
        XCTAssertTrue(card.abilities.contains("penalizeOnEliminatingDeputy"))
        XCTAssertEqual(card.attributes[.silentCard] as? String, "jail")
    }
}
