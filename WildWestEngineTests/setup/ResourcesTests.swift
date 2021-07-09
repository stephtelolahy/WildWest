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
        let hardcoded = EffectFamily.allCases.count + PlayReqFamily.allCases.count
        let scripted = sut.loadAbilities().count
        
        // Assert
        XCTAssertTrue(scripted >= hardcoded)
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
        let passiveAbilities = ["mustang",
                                "weapon",
                                "scope",
                                "flippedCards",
                                "bangsCancelable", 
                                "bangsPerTurn",
                                "handLimit",
                                
                                "playBangAsMissed",
                                "playMissedAsBang",
                                "playAnyCardAsMissed",
                                
                                "silentStartTurnDrawing2Cards",
                                "silentJail",
                                "silentDiamonds"]
        let activeAbilities = sut.loadAbilities().map { $0.name }
        let allAbilities = passiveAbilities + activeAbilities
        
        // When
        let cards = sut.loadCards()
        
        // Assert
        cards.forEach { card in
            card.abilities.keys.forEach {
                XCTAssertTrue(allAbilities.contains($0), "Invalid ability \($0) in card \(card.name)")
            }
        }
    }
    
    func test_DefaultPlayerAbilities() throws {
        // Given
        // When
        let cards = sut.loadCards().first { $0.type == .default && $0.name == "player" }!
        
        // Assert
        XCTAssertNotNil(cards.abilities["endTurn"])
        XCTAssertNotNil(cards.abilities["startTurnDrawing2Cards"])
        XCTAssertNotNil(cards.abilities["nextTurnOnPhase3"])
        XCTAssertNotNil(cards.abilities["nextTurnOnEliminated"])
        XCTAssertNotNil(cards.abilities["discardExcessCardsOnPhase3"])
        XCTAssertNotNil(cards.abilities["discardAllCardsOnEliminated"])
        XCTAssertNotNil(cards.abilities["gainRewardOnEliminatingOutlaw"])
    }
    
    func test_DefaultSheriffAbilities() throws {
        // Given
        // When
        let cards = sut.loadCards().first { $0.type == .default && $0.name == "sheriff" }!
        
        // Assert
        XCTAssertNotNil(cards.abilities["penalizeOnEliminatingDeputy"])
        XCTAssertNotNil(cards.abilities["silentJail"])
    }
}
