//
//  ResourcesDodgeCityTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 05/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class ResourcesDodgeCityTests: XCTestCase {

    private let sut: ResourcesLoaderProtocol = Resolver.resolve()
    
    func test_DodgeCityUniqueCards() throws {
        // Given
        let sut: ResourcesLoaderProtocol = Resolver.resolve(args: CardCollection.dodgecity)
        
        // When
        let cards = sut.loadCards()
        
        // Assert
        XCTAssertTrue(cards.contains { $0.name == "punch" })
        XCTAssertTrue(cards.contains { $0.name == "dodge" })
        XCTAssertTrue(cards.contains { $0.name == "springfield" })
        XCTAssertTrue(cards.contains { $0.name == "hideout" })
        XCTAssertTrue(cards.contains { $0.name == "binocular" })
        XCTAssertTrue(cards.contains { $0.name == "whisky" })
        XCTAssertTrue(cards.contains { $0.name == "tequila" })
        XCTAssertTrue(cards.contains { $0.name == "ragTime" })
        XCTAssertTrue(cards.contains { $0.name == "brawl" })
        
        XCTAssertTrue(cards.contains { $0.name == "elenaFuente" })
        XCTAssertTrue(cards.contains { $0.name == "seanMallory" })
        XCTAssertTrue(cards.contains { $0.name == "tequilaJoe" })
        XCTAssertTrue(cards.contains { $0.name == "pixiePete" })
        XCTAssertTrue(cards.contains { $0.name == "billNoface" })
        XCTAssertTrue(cards.contains { $0.name == "gregDigger" })
        XCTAssertTrue(cards.contains { $0.name == "herbHunter" })
        XCTAssertTrue(cards.contains { $0.name == "mollyStark" })
        XCTAssertTrue(cards.contains { $0.name == "joseDelgado" })
        XCTAssertTrue(cards.contains { $0.name == "chuckWengam" })
    }
    
    func test_DodgeCityCardSets() throws {
        // Given
        let sut: ResourcesLoaderProtocol = Resolver.resolve(args: CardCollection.dodgecity)
        
        // When
        let cards = sut.loadDeck()
        
        // Assert
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "8" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "5" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "6" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "K" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "dodge" && $0.value == "7" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "dodge" && $0.value == "K" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "6" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "6" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "indians" && $0.value == "5" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" && $0.value == "A" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "8" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "J" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "8" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "punch" && $0.value == "10" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "springfield" && $0.value == "K" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "whisky" && $0.value == "Q" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "tequila" && $0.value == "9" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "ragTime" && $0.value == "9" && $0.suit == "♥️" })
        
        XCTAssertTrue(cards.contains { $0.name == "hideout" && $0.value == "K" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "remington" && $0.value == "6" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "binocular" && $0.value == "10" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "revCarabine" && $0.value == "5" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "dynamite" && $0.value == "10" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" && $0.value == "5" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "barrel" && $0.value == "A" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "brawl" && $0.value == "J" && $0.suit == "♠️" })
    }
}
