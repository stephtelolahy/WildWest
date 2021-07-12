//
//  EquipTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class EquipTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanEquipCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "equip")
            .type(is: .blue)
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("equip", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.equip(player: "p1", card: "c1")])
    }
    
    func test_CanEquipMultipleCards() {
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "equip")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
            .abilities(are: "equip")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("equip", actor: "p1", card: .hand("c1")),
                               GMove("equip", actor: "p1", card: .hand("c2"))])
    }
    
    func test_CannotEquipTwoCopiesOftheSameCard() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "equip")
            .named("n1")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
            .named("n1")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .playing(mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_MustDiscardPreviousWeapon_IfEquipingNewOne() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .named("n1")
            .type(is: .blue)
            .attributes(are: [.weapon: 1])
            .abilities(are: "equip")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
            .named("n2")
            .attributes(are: [.weapon: 2])
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .playing(mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("equip", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.equip(player: "p1", card: "c1"),
                                .discardInPlay(player: "p1", card: "c2")])
    }
    
}
