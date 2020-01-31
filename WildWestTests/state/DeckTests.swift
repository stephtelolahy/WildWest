//
//  DeckTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DeckTests: XCTestCase {
    
    func test_ListContainsPassedCardsOnConstructor() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let sut = Deck(cards: [card1, card2], discardPile: [])
        
        // When
        // Assert
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c1", "c2"])
        XCTAssertTrue(sut.discardPile.isEmpty)
    }
    
    func test_AddCardAtTopOfPile_IfDiscardingCard() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = Deck(cards: [], discardPile: [card1, card2])
        
        // When
        sut.addToDiscard(card3)
        
        // Assert
        XCTAssertEqual(sut.discardPile.map { $0.identifier }, ["c3", "c1", "c2"])
        XCTAssertTrue(sut.cards.isEmpty)
    }
    
    func test_ReturnFirstCard_IfPulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = Deck(cards: [card1, card2, card3], discardPile: [])
        
        // When
        let card = sut.pull()
        
        // Assert
        XCTAssertEqual(card.identifier, "c1")
        XCTAssertEqual(sut.cards.map { $0.identifier }, ["c2", "c3"])
        XCTAssertTrue(sut.discardPile.isEmpty)
    }
    
    func test_ResetDeck_IfEmptyWhilePulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let sut = Deck(cards: [], discardPile: [card1, card2, card3])
        
        // When
        let card = sut.pull()
        
        // Assert
        
        let pulledCardId = card.identifier
        let remainingCardIds = ["c1", "c2", "c3"].filter { $0 != pulledCardId }
        XCTAssertTrue(sut.cards.map { $0.identifier }.isShuffed(from: remainingCardIds ))
        XCTAssertTrue(sut.discardPile.isEmpty)
    }
}
