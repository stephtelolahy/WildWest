//
//  PlayerTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/8/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PlayerTests: XCTestCase {
    
    var sut: PlayerProtocol!
    
    override func setUp() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        sut = Player(role: .deputy,
                     ability: .blackJack,
                     maxHealth: 4,
                     imageName: "image",
                     health: 2,
                     hand: [card1, card2],
                     inPlay: [card3])
    }
    
    func test_InitialProperties() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.role, .deputy)
        XCTAssertEqual(sut.ability, .blackJack)
        XCTAssertEqual(sut.imageName, "image")
        XCTAssertEqual(sut.maxHealth, 4)
        XCTAssertEqual(sut.health, 2)
        XCTAssertEqual(sut.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(sut.inPlay.map { $0.identifier }, ["c3"])
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
        XCTAssertEqual(sut.identifier, "blackJack")
    }
    
    func test_UpdateHand_IfAddingCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        sut = Player(role: .renegade,
                     ability: .willyTheKid,
                     maxHealth: 4,
                     imageName: "",
                     health: 1,
                     hand: [card1, card2],
                     inPlay: [])
        
        // When
        sut.addHand(card3)
        
        // Assert
        XCTAssertEqual(sut.hand.map { $0.identifier }, ["c1", "c2", "c3"])
        XCTAssertTrue(sut.inPlay.isEmpty)
    }
    
    func test_ReturnCard_IfRemovingHandById() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        sut = Player(role: .renegade,
                     ability: .willyTheKid,
                     maxHealth: 4,
                     imageName: "",
                     health: 1,
                     hand: [card1, card2, card3],
                     inPlay: [])
        
        // When
        let card = sut.removeHandById("c2")
        
        // Assert
        XCTAssertEqual(card?.identifier, "c2")
        XCTAssertEqual(sut.hand.map { $0.identifier }, ["c1", "c3"])
        XCTAssertTrue(sut.inPlay.isEmpty)
    }
    
    func test_ReturnNil_IfHandCardToRemoveIsNotFound() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        sut = Player(role: .renegade,
                     ability: .willyTheKid,
                     maxHealth: 4,
                     imageName: "",
                     health: 1,
                     hand: [card1, card2],
                     inPlay: [])
        
        // When
        let card = sut.removeHandById("c3")
        
        // Assert
        XCTAssertNil(card)
        XCTAssertEqual(sut.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertTrue(sut.inPlay.isEmpty)
    }
    
    func test_UpdateInPlay_ifAddingCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        sut = Player(role: .renegade,
                     ability: .willyTheKid,
                     maxHealth: 4,
                     imageName: "",
                     health: 1,
                     hand: [],
                     inPlay: [card1, card2])
        
        // When
        sut.addInPlay(card3)
        
        // Assert
        XCTAssertEqual(sut.inPlay.map { $0.identifier }, ["c1", "c2", "c3"])
        XCTAssertTrue(sut.hand.isEmpty)
    }
    
    func test_ReturnCard_IfRemovingInPlayById() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        sut = Player(role: .renegade,
                     ability: .willyTheKid,
                     maxHealth: 4,
                     imageName: "",
                     health: 1,
                     hand: [],
                     inPlay: [card1, card2, card3])
        
        // When
        let card = sut.removeInPlayById("c2")
        
        // Assert
        XCTAssertEqual(card?.identifier, "c2")
        XCTAssertEqual(sut.inPlay.map { $0.identifier }, ["c1", "c3"])
        XCTAssertTrue(sut.hand.isEmpty)
    }
    
    func test_ReturnNil_IfInPlayCardToRemoveIsNotFound() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        sut = Player(role: .renegade,
                     ability: .willyTheKid,
                     maxHealth: 4,
                     imageName: "",
                     health: 1,
                     hand: [],
                     inPlay: [card1, card2])
        
        // When
        let card = sut.removeInPlayById("c3")
        
        // Assert
        XCTAssertNil(card)
        XCTAssertEqual(sut.inPlay.map { $0.identifier }, ["c1", "c2"])
        XCTAssertTrue(sut.hand.isEmpty)
    }
}
