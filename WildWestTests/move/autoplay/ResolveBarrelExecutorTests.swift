//
//  ResolveBarrelExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class UseBarrelExecutorTests: XCTestCase {
    
    private let sut = UseBarrelExecutor()
    
    func test_ResolveShootChallenge_IfReturnHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let move = GameMove(name: .useBarrel, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(nil)])
    }
}

class FailBarelExecutorTests: XCTestCase {
    
    private let sut = FailBarelExecutor()
    
    func test_DoNotResolveShootChallenge_IfReturnNonHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let move = GameMove(name: .failBarrel, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard])
    }
}
