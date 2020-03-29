//
//  GameState+OutcomeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameState_OutcomeTests: XCTestCase {
    
    private let sut = MockGameStateProtocol()
    
    func test_OutlawWins_IfSheriffIsEliminated() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .renegade),
                MockPlayerProtocol().role(is: .deputy),
                MockPlayerProtocol().role(is: .outlaw),
            ])
        }
        
        // When
        // Assert
        XCTAssertEqual(sut.claculateOutcome(), .outlawWin)
    }
    
    func test_RenegateWins_IfIsLastAlive() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .renegade)
            ])
        }
        
        // When
        // Assert
        XCTAssertEqual(sut.claculateOutcome(), .renegadeWin)
    }
    
    func test_SheriffWins_IfAllOutlawsAreEliminated() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .sheriff),
                MockPlayerProtocol().role(is: .deputy)
            ])
        }
        
        // When
        // Assert
        XCTAssertEqual(sut.claculateOutcome(), .sheriffWin)
    }
    
    func test_NoOutcome_IfSheriffAndOutlawsAreNotEliminated() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .sheriff),
                MockPlayerProtocol().role(is: .outlaw),
                MockPlayerProtocol().role(is: .deputy),
                MockPlayerProtocol().role(is: .renegade),
            ])
        }
        
        // When
        // Assert
        XCTAssertNil(sut.claculateOutcome())
    }
    
    func test_NoOutcome_IfRenegadeAlive() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .sheriff),
                MockPlayerProtocol().role(is: .renegade),
            ])
        }
        
        // When
        // Assert
        XCTAssertNil(sut.claculateOutcome())
    }
    
    func test_NoOutcome_IfOutlawAlive() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .sheriff),
                MockPlayerProtocol().role(is: .outlaw),
            ])
        }
        
        // When
        // Assert
        XCTAssertNil(sut.claculateOutcome())
    }
    
}
