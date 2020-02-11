//
//  PlayerTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/8/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PlayerTests: XCTestCase {
    
    func test_SetHealth() {
        // Given
        let sut = Player(role: .deputy,
                         ability: .blackJack,
                         maxHealth: 4,
                         imageName: "",
                         health: 2,
                         hand: [],
                         inPlay: [])
        
        // When
        sut.setHealth(3)
        
        // Assert
        XCTAssertEqual(sut.health, 3)
    }
    
    func test_PlayerIdentifier_IsAbility() {
        // Given
        let sut = Player(role: .deputy,
                         ability: .blackJack,
                         maxHealth: 4,
                         imageName: "",
                         health: 2,
                         hand: [],
                         inPlay: [])
        
        // When
        // Assert
        XCTAssertEqual(sut.identifier, "blackJack")
    }
    
    func test_UpdateHand_IfAddingCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = Player(role: .renegade,
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
    
    func test_UpdateInPlay_ifAddingCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = Player(role: .renegade,
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
        let sut = Player(role: .renegade,
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
        let sut = Player(role: .renegade,
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
