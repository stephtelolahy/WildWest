//
//  SilentInPlayTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 13/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class SilentInPlayTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_SilentOthersBarrel_IfHavingAttributeSilentInPlayAndYourTurn() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "barrel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .cancelable(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .attributes(are: [.silentInPlay: true])
        let mockState = MockStateProtocol()
            .withDefault()
            .hit(is: mockHit1)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p2")
        let event = GEvent.addHit(hit: GHit(name: "n1", players: ["p1"], abilities: [], cancelable: 1))
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_DoNotSilentOthersBarrel_IfHavingAttributeSilentInPlayButNotYourTurn() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "barrel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .cancelable(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .attributes(are: [.silentInPlay: true])
        let mockState = MockStateProtocol()
            .withDefault()
            .hit(is: mockHit1)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "pX")
        let event = GEvent.addHit(hit: GHit(name: "n1", players: ["p1"], abilities: [], cancelable: 1))
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNotNil(moves)
    }
}
