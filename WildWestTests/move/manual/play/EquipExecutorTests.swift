//
//  EquipExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EquipExecutorTests: XCTestCase {
    
    private let sut = EquipExecutor()
    
    func test_PutCardInPlay_IfEquipping() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.schofield))
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .schofield)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPutInPlay("p1", "c1")])
    }
    
    func test_DiscardPreviousGun_IfArmingNewGun() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.schofield))
            .playing(MockCardProtocol().identified(by: "c2").named(.volcanic))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .schofield)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardInPlay("p1", "c2"),
                                 .playerPutInPlay("p1", "c1")])
    }
    
}
