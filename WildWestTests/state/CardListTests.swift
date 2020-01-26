//
//  CardListTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CardListTests: XCTestCase {
    
    func test_ListContainsPassedCardsOnConstructor() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = CardList(cards: [card1, card2])
        
        // When
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2"])
    }
    
    func test_AddPassedCardAtEndOfList_IfAddingCard() {
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
    
    func test_ListContainsAllPassedCards_IfAddingAll() {
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
    
    func test_ReturnFirstCard_IfRemovingFirst() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = CardList(cards: [card1, card2, card3])
        
        // When
        let card = sut.removeFirst()
        
        // Assert
        XCTAssertEqual(card?.identifier, "c1")
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c2", "c3"])
    }
    
    func test_ReturnNil_IfRemovingFirstOnEmptyList() {
        // Given
        let sut = CardList(cards: [])
        
        // When
        let card = sut.removeFirst()
        
        // Assert
        XCTAssertNil(card)
    }
    
    func test_ReturnCardwithPassedIdentifier_IfRemovingCardByIdentifier() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = CardList(cards: [card1, card2, card3])
        
        // When
        let card = sut.removeById("c2")
        
        // Assert
        XCTAssertEqual(card?.identifier, "c2")
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c3"])
    }
    
    func test_ReturnNil_IfCardToRemoveIsNotFound() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = CardList(cards: [card1, card2])
        
        // When
        let card = sut.removeById("c3")
        
        // Assert
        XCTAssertNil(card)
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2"])
    }
    
    func test_ReturnAllCards_IfRemovingAll() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = CardList(cards: [card1, card2])
        
        // When
        let cards = sut.removeAll()
        
        // Assert
        XCTAssertEqual(cards.map { $0.identifier }, ["c1", "c2"])
        XCTAssertTrue(sut.cards.isEmpty)
    }
}
