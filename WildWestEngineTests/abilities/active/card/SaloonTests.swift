//
//  SaloonTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 02/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class SaloonTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlaySaloon_IfSomePlayerDamaged() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "saloon")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .health(is: 4)
            .maxHealth(is: 4)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .health(is: 1)
            .maxHealth(is: 4)
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p3", "p1", "p2")
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("saloon", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                 .gainHealth(player: "p2"),
                                 .gainHealth(player: "p3")])
    }
    
    func test_CannotPlaySaloon_IfAllPlayersFullLife() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "saloon")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .health(is: 4)
            .maxHealth(is: 4)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .health(is: 4)
            .maxHealth(is: 4)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
