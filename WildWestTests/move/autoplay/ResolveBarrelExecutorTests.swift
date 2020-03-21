//
//  ResolveBarrelExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ResolveBarrelExecutorTests: XCTestCase {
    
    private let sut = ResolveBarrelExecutor()
    
    func test_ResolveShootChallenge_IfReturnHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().suit(is: .hearts)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let move = GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .barrel)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(nil)])
    }
    
    func test_DoNotResolveShootChallenge_IfReturnNonHeartFromDeck() {
        // Given
        let mockCard = MockCardProtocol().identified(by: "c1").suit(is: .diamonds)
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.deck.get).thenReturn([mockCard, MockCardProtocol()])
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let move = GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .barrel)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard])
    }
}
