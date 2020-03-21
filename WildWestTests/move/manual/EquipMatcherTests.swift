//
//  EquipMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EquipMatcherTests: XCTestCase {
    
    private let sut = EquipMatcher()
    
    func test_CanEquip_IfYourTurnAndOwnCard() {
        // Given
        let mockCard1 = MockCardProtocol()
            .named(.schofield)
            .identified(by: "c1")
        let mockCard2 = MockCardProtocol()
            .named(.scope)
            .identified(by: "c2")
        let mockCard3 = MockCardProtocol()
            .named(.dynamite)
            .identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2, mockCard3)
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .schofield),
            GameMove(name: .play, actorId: "p1", cardId: "c2", cardName: .scope),
            GameMove(name: .play, actorId: "p1", cardId: "c3", cardName: .dynamite)
        ])
    }
    
    func test_CannotEquip_IfAlreadyPlayingCardWithTheSameName() {
        // Given
        let mockCard1 = MockCardProtocol().named(.mustang)
        let mockCard2 = MockCardProtocol().named(.mustang)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1)
            .playing(mockCard2)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotEquipJail() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.jail)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
