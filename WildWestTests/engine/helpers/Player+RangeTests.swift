//
//  Player+RangeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class Player_RangeTests: XCTestCase {
    
    func test_DefaultBangsLimitPerTurnIs1() {
        // Given
        let sut = MockPlayerProtocol()
            .noCardsInPlay()
            .ability(is: .bartCassidy)
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 1)
    }
    
    func test_UnlimitedBangsPerTurn_IfPlayingVolcanic() {
        // Given
        let sut = MockPlayerProtocol()
            .playing(MockCardProtocol().named(.volcanic))
            .ability(is: .bartCassidy)
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }
    
    func test_UnlimitedBangsPerTurn_IfFigureIsWillyTheKid() {
        // Given
        let sut = MockPlayerProtocol()
        Cuckoo.stub(sut) { mock in
            when(mock.ability.get).thenReturn(.willyTheKid)
            when(mock.inPlay.get).thenReturn([])
        }
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }
    
}
