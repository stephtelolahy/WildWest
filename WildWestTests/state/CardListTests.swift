//
//  CardListTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CardListTests: XCTestCase {
    
    func test_GetCards() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = CardList(cards: [card1, card2])
        
        // When
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2"])
    }
    
    func test_AddCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = CardList(cards: [card1, card2])
        
        // When
        sut.add(card3)
        
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2", "c3"])
    }
    
    func test_AddAll() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = CardList(cards: [card1])
        
        // When
        sut.addAll([card2, card3])
        
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2", "c3"])
    }
    
    func test_RemoveFirst() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = CardList(cards: [card1, card2, card3])
        
        // When
        let card = sut.removeFirst()
        
        // Assert
        XCTAssertEqual(card.identifier, "c1")
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c2", "c3"])
    }
    
    func test_RemoveCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = CardList(cards: [card1, card2, card3])
        
        // When
        sut.removeById("c2")
        
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c3"])
    }
    
    func test_RemoveCardDoesNothing_IfNotFound() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = CardList(cards: [card1, card2])
        
        // When
        sut.removeById("c3")
        
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2"])
    }
    
    func test_RemoveAll() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = CardList(cards: [card1, card2])
        
        // When
        sut.removeAll()
        
        // Assert
        XCTAssertTrue(sut.cards.isEmpty)
    }
}
