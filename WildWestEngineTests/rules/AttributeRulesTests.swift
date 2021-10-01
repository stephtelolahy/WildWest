//
//  AttributeRulesTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 14/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine

class AttributeRulesTests: XCTestCase {
    
    // MARK: - maxHealth
    
    func test_MaxHealth_IsBullets() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(are: [.bullets: 3])
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.maxHealth(for: mockPlayer), 3)
    }
    
    // MARK: - weapon
    
    func test_DefaultGurnRange_Is1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.weapon(for: mockPlayer), 1)
    }
    
    func test_GunRange_IsInPlayCardAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().withDefault().attributes(are: [.weapon: 5]))
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.weapon(for: mockPlayer), 5)
    }
    
    // MARK: - bangsPerTurn
    
    func test_DefaultBangsPerTurnIs1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.bangsPerTurn(for: mockPlayer), 1)
    }
    
    func test_NoLimitOnBangsPerTurn_IfHavingAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(are: [.bangsPerTurn: 0])
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.bangsPerTurn(for: mockPlayer), 0)
    }
    
    func test_NoLimitOnBangsPerTurn_IfPlayingCardWithAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().withDefault().attributes(are: [.bangsPerTurn: 0]))
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.bangsPerTurn(for: mockPlayer), 0)
    }
    
    // MARK: - bangsCancelable
    
    func test_DefaultNeededMissesToCancelBangIs1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.bangsCancelable(for: mockPlayer), 1)
    }
    
    func test_NeededMissesToCancelBangIs12_IfHAvingAbility() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(are: [.bangsCancelable: 2])
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.bangsCancelable(for: mockPlayer), 2)
    }
    
    // MARK: - flippedCards
    
    func test_DefaultFlippedCards_Is1() {
        // Given
        let mockPlayer = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.flippedCards(for: mockPlayer), 1)
    }
    
    func test_FlippedCards_IsAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(are: [.flippedCards: 2])
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.flippedCards(for: mockPlayer), 2)
    }
    
    // MARK: - handLimit
    
    func test_DefaultHandLimit_IsHealth() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .health(is: 4)
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.handLimit(for: mockPlayer), 4)
    }
    
    func test_HandLimit_IsAttribute() {
        // Given
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .health(is: 4)
            .attributes(are: [.handLimit: 10])
        
        // When
        // Assert
        XCTAssertEqual(AttributeRules.handLimit(for: mockPlayer), 10)
    }
    
}
