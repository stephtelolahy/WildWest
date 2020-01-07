//
//  CardListTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CardListTests: XCTestCase {
    
    // TODO: inject mock cards, so then when card properties changed, these instances won't be obsolete

    func test_GetCards() {
        // Given
        let card1 = Card(name: .barrel, value: "2", suit: .diamonds)
        let card2 = Card(name: .scope, value: "8", suit: .clubs)
        let sut = CardList(cards: [card1, card2])
        
        // When
        // Assert
        XCTAssertEqual(sut.cards as? [Card], [card1, card2])
    }
    
    func test_AddCard() {
        // Given
        let card1 = Card(name: .barrel, value: "2", suit: .diamonds)
        let card2 = Card(name: .scope, value: "8", suit: .clubs)
        let card3 = Card(name: .barrel, value: "J", suit: .hearts)
        let sut = CardList(cards: [card1, card2])
        
        // When
        sut.add(card3)
        
        // Assert
        XCTAssertEqual(sut.cards as? [Card], [card1, card2, card3])
    }
    
    func test_AddAll() {
        // Given
        let card1 = Card(name: .barrel, value: "2", suit: .diamonds)
        let card2 = Card(name: .scope, value: "8", suit: .clubs)
        let card3 = Card(name: .barrel, value: "J", suit: .hearts)
        let sut = CardList(cards: [card1])
        
        // When
        sut.addAll([card2, card3])
        
        // Assert
        XCTAssertEqual(sut.cards as? [Card], [card1, card2, card3])
    }
    
    func test_RemoveFirst() {
        // Given
        let card1 = Card(name: .barrel, value: "2", suit: .diamonds)
        let card2 = Card(name: .scope, value: "8", suit: .clubs)
        let card3 = Card(name: .barrel, value: "J", suit: .hearts)
        let sut = CardList(cards: [card1, card2, card3])
        
        // When
        let surprise = sut.removeFirst()
        
        // Assert
        XCTAssertEqual(surprise as? Card, card1)
        XCTAssertEqual(sut.cards as? [Card], [card2, card3])
    }
    
    func test_RemoveFirstThrowsError_IfEmpty() {
        XCTFail()
    }
    
    func test_RemoveCard() {
        // Given
        let card1 = Card(name: .barrel, value: "2", suit: .diamonds)
        let card2 = Card(name: .scope, value: "8", suit: .clubs)
        let card3 = Card(name: .barrel, value: "J", suit: .hearts)
        let sut = CardList(cards: [card1, card2, card3])
        
        // When
        sut.removeById("barrel-2-diamonds")
        
        // Assert
        XCTAssertEqual(sut.cards as? [Card], [card2, card3])
    }
    
    func test_RemoveCardThrowsError_IfNotFound() {
        XCTFail()
    }
    
    func test_RemoveAll() {
        // Given
        let card1 = Card(name: .barrel, value: "2", suit: .diamonds)
        let card2 = Card(name: .scope, value: "8", suit: .clubs)
        let sut = CardList(cards: [card1, card2])
        
        // When
        sut.removeAll()
        
        // Assert
        XCTAssertTrue(sut.cards.isEmpty)
    }
}
