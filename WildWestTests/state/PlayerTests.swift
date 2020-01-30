//
//  PlayerTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/8/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PlayerTests: XCTestCase {
    
    var sut: Player!
    
    override func setUp() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockHand = MockCardListProtocol().containing(card1, card2)
        let mockInPlay = MockCardListProtocol().containing(card3)
        let figure = Figure(ability: .willyTheKid, bullets: 4, imageName: "willy_image", description: "willy_description")
        sut = Player(role: .deputy,
                     figure: figure,
                     maxHealth: 4,
                     health: 2,
                     hand: mockHand,
                     inPlay: mockInPlay)
    }
    
    func test_InitialProperties() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.role, .deputy)
        XCTAssertEqual(sut.ability, .willyTheKid)
        XCTAssertEqual(sut.imageName, "willy_image")
        XCTAssertEqual(sut.maxHealth, 4)
        XCTAssertEqual(sut.health, 2)
        XCTAssertEqual(sut.hand.cards.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(sut.inPlay.cards.map { $0.identifier }, ["c3"])
    }
    
    func test_SetHealth() {
        // Given
        // When
        sut.setHealth(3)
        
        // Assert
        XCTAssertEqual(sut.health, 3)
    }
    
    func test_PlayerIdentifier_IsAbility() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.identifier, "willyTheKid")
    }
}
