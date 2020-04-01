//
//  Player+AbilityTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class Player_AbilityTests: XCTestCase {
    
    func test_DefaultLimitOnBangsPerTurnIs1() {
        // Given
        let sut = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 1)
    }
    
    func test_NoLimitOnBangsPerTurn_IfPlayingVolcanic() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().named(.volcanic))
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }
    
    func test_NoLimitOnBangsPerTurn_IfHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasNoLimitOnBangsPerTurn: true])
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }
    
    func test_DefaultMustangCount_Is0() {
        // Given
        let sut = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(sut.mustangCount, 0)
    }
    
    func test_HasAMustangAtAllTimes_IfHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasMustangAllTimes: true])
        
        // When
        // Assert
        XCTAssertEqual(sut.mustangCount, 1)
    }
    
    func test_HasDoubleMustang_IfPlayingMustangAndHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasMustangAllTimes: true])
            .playing(MockCardProtocol().named(.mustang))
        
        // When
        // Assert
        XCTAssertEqual(sut.mustangCount, 2)
    }
    
    func test_DefaultScopeCount_Is0() {
        // Given
        let sut = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(sut.scopeCount, 0)
    }
    
    func test_HasAScopeAtAllTimes_IfHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasScopeAllTimes: true])
        
        // When
        // Assert
        XCTAssertEqual(sut.scopeCount, 1)
    }
    
    func test_HasDoubleScope_IfPlayingMustangAndHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasScopeAllTimes: true])
            .playing(MockCardProtocol().named(.scope))
        
        // When
        // Assert
        XCTAssertEqual(sut.scopeCount, 2)
    }
    
    func test_DefaultBarrelCount_Is0() {
        // Given
        let sut = MockPlayerProtocol().withDefault()
        
        // When
        // Assert
        XCTAssertEqual(sut.barrelsCount, 0)
    }
    
    func test_HasABarrelAtAllTimes_IfHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasBarrelAllTimes: true])
        
        // When
        // Assert
        XCTAssertEqual(sut.barrelsCount, 1)
    }
    
    func test_HasDoubleBarrel_IfPlayingMustangAndHavingAbility() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .abilities(are: [.hasBarrelAllTimes: true])
            .playing(MockCardProtocol().named(.barrel))
        
        // When
        // Assert
        XCTAssertEqual(sut.barrelsCount, 2)
    }
}
