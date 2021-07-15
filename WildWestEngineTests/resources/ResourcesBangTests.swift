//
//  ResourcesBangTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 05/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Resolver

class ResourcesBangTests: XCTestCase {
    
    private let sut: ResourcesLoaderProtocol = Resolver.resolve()
    
    func test_BangUniqueCards() throws {
        // Given
        let sut: ResourcesLoaderProtocol = Resolver.resolve(args: CardCollection.bang)
        
        // When
        let cards = sut.loadCards()
        
        // Assert
        XCTAssertTrue(cards.contains { $0.name == "barrel" })
        XCTAssertTrue(cards.contains { $0.name == "dynamite" })
        XCTAssertTrue(cards.contains { $0.name == "jail" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" })
        XCTAssertTrue(cards.contains { $0.name == "remington" })
        XCTAssertTrue(cards.contains { $0.name == "revCarabine" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" })
        XCTAssertTrue(cards.contains { $0.name == "scope" })
        XCTAssertTrue(cards.contains { $0.name == "volcanic" })
        XCTAssertTrue(cards.contains { $0.name == "winchester" })
        XCTAssertTrue(cards.contains { $0.name == "bang" })
        XCTAssertTrue(cards.contains { $0.name == "beer" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" })
        XCTAssertTrue(cards.contains { $0.name == "duel" })
        XCTAssertTrue(cards.contains { $0.name == "gatling" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" })
        XCTAssertTrue(cards.contains { $0.name == "indians" })
        XCTAssertTrue(cards.contains { $0.name == "missed" })
        XCTAssertTrue(cards.contains { $0.name == "panic" })
        XCTAssertTrue(cards.contains { $0.name == "saloon" })
        XCTAssertTrue(cards.contains { $0.name == "stagecoach" })
        XCTAssertTrue(cards.contains { $0.name == "wellsFargo" })
        
        XCTAssertTrue(cards.contains { $0.name == "bartCassidy" })
        XCTAssertTrue(cards.contains { $0.name == "blackJack" })
        XCTAssertTrue(cards.contains { $0.name == "calamityJanet" })
        XCTAssertTrue(cards.contains { $0.name == "elGringo" })
        XCTAssertTrue(cards.contains { $0.name == "jesseJones" })
        XCTAssertTrue(cards.contains { $0.name == "jourdonnais" })
        XCTAssertTrue(cards.contains { $0.name == "kitCarlson" })
        XCTAssertTrue(cards.contains { $0.name == "luckyDuke" })
        XCTAssertTrue(cards.contains { $0.name == "paulRegret" })
        XCTAssertTrue(cards.contains { $0.name == "pedroRamirez" })
        XCTAssertTrue(cards.contains { $0.name == "roseDoolan" })
        XCTAssertTrue(cards.contains { $0.name == "sidKetchum" })
        XCTAssertTrue(cards.contains { $0.name == "slabTheKiller" })
        XCTAssertTrue(cards.contains { $0.name == "suzyLafayette" })
        XCTAssertTrue(cards.contains { $0.name == "vultureSam" })
        XCTAssertTrue(cards.contains { $0.name == "willyTheKid" })
    }
    
    func test_BangCardSets() throws {
        // Given
        let sut: ResourcesLoaderProtocol = Resolver.resolve(args: CardCollection.bang)
        
        // When
        let cards = sut.loadDeck()
        
        // Assert
        XCTAssertTrue(cards.contains { $0.name == "barrel" && $0.value == "Q" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "barrel" && $0.value == "K" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "dynamite" && $0.value == "2" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "jail" && $0.value == "J" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "jail" && $0.value == "4" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "jail" && $0.value == "10" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" && $0.value == "8" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "mustang" && $0.value == "9" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "remington" && $0.value == "K" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "revCarabine" && $0.value == "A" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" && $0.value == "J" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" && $0.value == "Q" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "schofield" && $0.value == "K" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "scope" && $0.value == "A" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "volcanic" && $0.value == "10" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "volcanic" && $0.value == "10" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "winchester" && $0.value == "8" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "A" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "2" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "3" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "4" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "5" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "6" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "7" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "8" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "9" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "10" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "J" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "Q" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "K" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "A" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "2" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "3" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "4" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "5" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "6" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "7" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "8" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "9" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "Q" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "K" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "bang" && $0.value == "A" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "6" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "7" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "8" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "9" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "10" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "beer" && $0.value == "J" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "K" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "9" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "10" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "catBalou" && $0.value == "J" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "duel" && $0.value == "Q" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "duel" && $0.value == "J" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "duel" && $0.value == "8" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "gatling" && $0.value == "10" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" && $0.value == "9" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "generalstore" && $0.value == "Q" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "indians" && $0.value == "K" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "indians" && $0.value == "A" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "10" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "J" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "Q" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "K" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "A" && $0.suit == "♣️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "2" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "3" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "4" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "5" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "6" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "7" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "missed" && $0.value == "8" && $0.suit == "♠️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "J" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "Q" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "A" && $0.suit == "♥️" })
        XCTAssertTrue(cards.contains { $0.name == "panic" && $0.value == "8" && $0.suit == "♦️" })
        XCTAssertTrue(cards.contains { $0.name == "saloon" && $0.value == "5" && $0.suit == "♥️" })
        XCTAssertTrue(cards.filter { $0.name == "stagecoach" && $0.value == "9" && $0.suit == "♠️" }.count == 2)
        XCTAssertTrue(cards.contains { $0.name == "wellsFargo" && $0.value == "3" && $0.suit == "♥️" })
    }
}
    
