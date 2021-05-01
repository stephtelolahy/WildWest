//
//  ResourcesTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable force_cast
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Resolver

class ResourcesTests: XCTestCase {
    
    private let sut: ResourcesLoaderProtocol = Resolver.resolve()
    
    func test_ResourcesCount() throws {
        // Given
        // When
        let cards = sut.loadCards()
        let abilities = sut.loadAbilities()
        
        // Assert
        XCTAssertEqual(cards.filter { $0.type == .figure }.count, 16)
        XCTAssertEqual(cards.filter { $0.type == .brown || $0.type == .blue }.count, 22)
        XCTAssertEqual(abilities.count, 47)
        XCTAssertEqual(PlayReqMatcher().playReqIds.count, 25)
        XCTAssertEqual(EffectMatcher().effectIds.count, 23)
    }
    
    func test_Abilities_HaveValidRequirements() throws {
        // Given
        let playReqs = PlayReqMatcher().playReqIds
        
        // When
        let abilities = sut.loadAbilities()
        
        // Assert
        abilities.forEach { ability in
            ability.canPlay.forEach {
                XCTAssertTrue(playReqs.contains($0.key), "PlayRequirement \($0.key) not found")
            }
        }
    }
    
    func test_Abilities_HaveValidEffects() throws {
        // Given
        let effects = EffectMatcher().effectIds
        
        // When
        let abilities = sut.loadAbilities()
        
        // Assert
        abilities.forEach { ability in
            ability.onPlay.forEach {
                let action = $0["action"] as! String
                XCTAssertTrue(effects.contains(action), "Effect \(action) not found")
            }
        }
    }
    
    func test_Cards_HaveValidAbilities() throws {
        // Given
        let passiveAbilities = ["bullets",
                                "mustang",
                                "weapon",
                                "scope",
                                "flippedCards",
                                "bangsCancelable", 
                                "bangsPerTurn",
                                "playBangAsMissed",
                                "playMissedAsBang",
                                "silentStartTurnOnPhase1"]
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
    
    func test_Defaults_AreValidAbilities() throws {
        // Given
        let abilities = sut.loadAbilities().map { $0.name }
        
        // When
        let defaults = sut.loadDefaults()
        
        // Assert
        defaults.common.keys.forEach { 
            XCTAssertTrue(abilities.contains($0), "Invalid ability \($0) in defaults")
        }
    }
    
    func test_DefaultAbilities() throws {
        // Given
        // When
        let abilities = sut.loadDefaults()
        
        // Assert
        XCTAssertNotNil(abilities.common["endTurn"])
        XCTAssertNotNil(abilities.common["startTurnOnPhase1"])
        XCTAssertNotNil(abilities.common["nextTurnOnPhase3"])
        XCTAssertNotNil(abilities.common["nextTurnOnEliminated"])
        XCTAssertNotNil(abilities.common["discardExcessCardsOnPhase3"])
        XCTAssertNotNil(abilities.common["discardAllCardsOnEliminated"])
        XCTAssertNotNil(abilities.common["gainRewardOnEliminatingOutlaw"])
        XCTAssertNotNil(abilities.sheriff["penalizeOnEliminatingDeputy"])
        XCTAssertNotNil(abilities.sheriff["silentJail"])
    }
    
    func test_BangCards() throws {
        // Given
        // When
        let cards = sut.loadCards()
        
        // Assert
        
        XCTAssertTrue(cards.contains { $0.name == "barrel" })
        XCTAssertTrue(cards.contains { $0.name == "dynamite" })
        XCTAssertTrue(cards.contains { $0.name == "jail" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" })
        XCTAssertTrue(cards.contains { $0.name == "remington" })
        XCTAssertTrue(cards.contains { $0.name == "revCarabine" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" })
        XCTAssertTrue(cards.contains { $0.name == "scope" })
        XCTAssertTrue(cards.contains { $0.name == "volcanic" })
        XCTAssertTrue(cards.contains { $0.name == "winchester" })
        XCTAssertTrue(cards.contains { $0.name == "bang" })
        XCTAssertTrue(cards.contains { $0.name == "beer" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" })
        XCTAssertTrue(cards.contains { $0.name == "duel" })
        XCTAssertTrue(cards.contains { $0.name == "gatling" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" })
        XCTAssertTrue(cards.contains { $0.name == "indians" })
        XCTAssertTrue(cards.contains { $0.name == "missed" })
        XCTAssertTrue(cards.contains { $0.name == "panic" })
        XCTAssertTrue(cards.contains { $0.name == "saloon" })
        XCTAssertTrue(cards.contains { $0.name == "stagecoach" })
        XCTAssertTrue(cards.contains { $0.name == "wellsFargo" })
        
        XCTAssertTrue(cards.contains { $0.name == "bartCassidy" })
        XCTAssertTrue(cards.contains { $0.name == "blackJack" })
        XCTAssertTrue(cards.contains { $0.name == "calamityJanet" })
        XCTAssertTrue(cards.contains { $0.name == "elGringo" })
        XCTAssertTrue(cards.contains { $0.name == "jesseJones" })
        XCTAssertTrue(cards.contains { $0.name == "joudonais" })
        XCTAssertTrue(cards.contains { $0.name == "kitCarlson" })
        XCTAssertTrue(cards.contains { $0.name == "luckyDuke" })
        XCTAssertTrue(cards.contains { $0.name == "paulRegret" })
        XCTAssertTrue(cards.contains { $0.name == "pedroRamirez" })
        XCTAssertTrue(cards.contains { $0.name == "roseDoolan" })
        XCTAssertTrue(cards.contains { $0.name == "sidKetchum" })
        XCTAssertTrue(cards.contains { $0.name == "slabTheKiller" })
        XCTAssertTrue(cards.contains { $0.name == "suzyLafayette" })
        XCTAssertTrue(cards.contains { $0.name == "vultureSam" })
        XCTAssertTrue(cards.contains { $0.name == "willyTheKid" })
    }
    
    func test_BangCardsList() throws {
        // Given
        // When
        let cards = sut.loadDeck()
        
        // Assert
        XCTAssertTrue(cards.contains { $0.name == "barrel" && $0.value == "Q" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "barrel" && $0.value == "K" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "dynamite" && $0.value == "2" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "jail" && $0.value == "J" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "jail" && $0.value == "4" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "jail" && $0.value == "10" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" && $0.value == "8" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" && $0.value == "9" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "remington" && $0.value == "K" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "revCarabine" && $0.value == "A" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" && $0.value == "J" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" && $0.value == "Q" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" && $0.value == "K" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "scope" && $0.value == "A" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "volcanic" && $0.value == "10" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "volcanic" && $0.value == "10" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "winchester" && $0.value == "8" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "A" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "2" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "3" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "4" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "5" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "6" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "7" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "8" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "9" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "10" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "J" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "Q" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "K" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "A" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "2" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "3" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "4" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "5" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "6" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "7" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "8" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "9" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "Q" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "K" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "A" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "6" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "7" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "8" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "9" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "10" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "J" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "K" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "9" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "10" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "J" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "duel" && $0.value == "Q" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "duel" && $0.value == "J" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "duel" && $0.value == "8" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "gatling" && $0.value == "10" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" && $0.value == "9" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" && $0.value == "Q" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "indians" && $0.value == "K" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "indians" && $0.value == "A" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "10" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "J" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "Q" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "K" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "A" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "2" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "3" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "4" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "5" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "6" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "7" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "8" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "J" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "Q" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "A" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "8" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "saloon" && $0.value == "5" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "stagecoach" && $0.value == "9" && $0.suit == "♠️" })
        XCTAssertTrue(cards.filter { $0.name == "stagecoach" }.count == 2)
        XCTAssertTrue(cards.contains { $0.name == "wellsFargo" && $0.value == "3" && $0.suit == "♥️" })
    }
}
