//
//  PlayerAttributesTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 14/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine

class PlayerAttributesTests: XCTestCase {
    
    // MARK: - maxHealth
    
    func test_MaxHealth_IsBullets() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .attributes(are: [.bullets: 3])
        let sut = GPlayer(mockPlayer)
        
        // When
        // Assert
        XCTAssertEqual(sut.maxHealth, 3)
    }
    
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
            .playing(MockCardProtocol().withDefault().attributes(are: [.weapon: 5]))
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
            .attributes(are: [.bangsPerTurn: 0])
        let sut = GPlayer(mockPlayer)
        
        // When
        // Assert
        XCTAssertEqual(sut.bangsPerTurn, 0)
    }
    
    func test_NoLimitOnBangsPerTurn_IfPlayingCardWithAttribute() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().withDefault().attributes(are: [.bangsPerTurn: 0]))
        let sut = GPlayer(mockPlayer)
        
        // When
        // Assert
        XCTAssertEqual(sut.bangsPerTurn, 0)
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
            .attributes(are: [.bangsCancelable: 2])
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
            .attributes(are: [.flippedCards: 2])
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
            .attributes(are: [.handLimit: 10])
        let sut = GPlayer(mockPlayer)
        
        // When
        // Assert
        XCTAssertEqual(sut.handLimit, 10)
    }
    
}
