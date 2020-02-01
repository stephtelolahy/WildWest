
//
//  GameResourcesTests+Cards.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameResourcesTests_Cards: XCTestCase {

    private lazy var cards: [CardProtocol] = {
        let jsonReader = JsonReader(bundle: Bundle(for: type(of: self)))
        let sut: ResourcesProviderProtocol = ResourcesProvider(jsonReader: jsonReader)
        return sut.allCards()
    }()
    
    func test_Barrel() {
        XCTAssertTrue(cards.contains { $0.name == .barrel && $0.value == "Q" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .barrel && $0.value == "K" && $0.suit == .spades })
    }
    
    func test_Dynamite() {
        XCTAssertTrue(cards.contains { $0.name == .dynamite && $0.value == "2" && $0.suit == .hearts })
    }
    
    func test_Jail() {
        XCTAssertTrue(cards.contains { $0.name == .jail && $0.value == "J" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .jail && $0.value == "4" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .jail && $0.value == "10" && $0.suit == .spades })
    }
    
    func test_Mustang() {
        XCTAssertTrue(cards.contains { $0.name == .mustang && $0.value == "8" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .mustang && $0.value == "9" && $0.suit == .hearts })
    }
    
    func test_Remington() {
        XCTAssertTrue(cards.contains { $0.name == .remington && $0.value == "K" && $0.suit == .clubs })
    }
    
    func test_RevCarbine() {
        XCTAssertTrue(cards.contains { $0.name == .revCarbine && $0.value == "A" && $0.suit == .clubs })
    }
    
    func test_Schofield() {
        XCTAssertTrue(cards.contains { $0.name == .schofield && $0.value == "J" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .schofield && $0.value == "Q" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .schofield && $0.value == "K" && $0.suit == .spades })
    }
    
    func test_Scope() {
        XCTAssertTrue(cards.contains { $0.name == .scope && $0.value == "A" && $0.suit == .spades })
    }
    
    func test_Volcanic() {
        XCTAssertTrue(cards.contains { $0.name == .volcanic && $0.value == "10" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .volcanic && $0.value == "10" && $0.suit == .clubs })
    }
    
    func test_Winchester() {
        XCTAssertTrue(cards.contains { $0.name == .winchester && $0.value == "8" && $0.suit == .spades })
    }
    
    func test_Bang() {
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "A" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "2" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "3" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "4" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "5" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "6" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "7" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "8" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "9" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "10" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "J" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "Q" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "K" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "A" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "2" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "3" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "4" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "5" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "6" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "7" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "8" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "9" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "Q" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "K" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .shoot && $0.value == "A" && $0.suit == .hearts })
    }
    
    func test_Beer() {
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "6" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "7" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "8" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "9" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "10" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "J" && $0.suit == .hearts })
    }
    
    func test_CatBalou() {
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "K" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "9" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "10" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "J" && $0.suit == .diamonds })
    }
    
    func test_Duel() {
        XCTAssertTrue(cards.contains { $0.name == .duel && $0.value == "Q" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .duel && $0.value == "J" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .duel && $0.value == "8" && $0.suit == .clubs })
    }
    
    func test_Gatling() {
        XCTAssertTrue(cards.contains { $0.name == .gatling && $0.value == "10" && $0.suit == .hearts })
    }
    
    func test_GeneralStore() {
        XCTAssertTrue(cards.contains { $0.name == .generalStore && $0.value == "9" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .generalStore && $0.value == "Q" && $0.suit == .spades })
    }
    
    func test_Indians() {
        XCTAssertTrue(cards.contains { $0.name == .indians && $0.value == "K" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .indians && $0.value == "A" && $0.suit == .diamonds })
    }
    
    func test_Missed() {
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "10" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "J" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "Q" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "K" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "A" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "2" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "3" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "4" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "5" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "6" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "7" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .missed && $0.value == "8" && $0.suit == .spades })
    }
    
    func test_Panic() {
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "J" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "Q" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "A" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "8" && $0.suit == .diamonds })
    }
    
    func test_Saloon() {
        XCTAssertTrue(cards.contains { $0.name == .saloon && $0.value == "5" && $0.suit == .hearts })
    }
    
    func test_Stagecoach() {
        XCTAssertTrue(cards.contains { $0.name == .stagecoach && $0.value == "9" && $0.suit == .spades })
    }
    
    func test_WellsFargo() {
        XCTAssertTrue(cards.contains { $0.name == .wellsFargo && $0.value == "3" && $0.suit == .hearts })
    }
    
    func test_AllCardsHaveValidImage() {
        let bundle = Bundle(for: type(of: self))
        XCTAssertTrue(cards.allSatisfy { UIImage(named: $0.imageName, in: bundle, compatibleWith: nil) != nil })
    }

}
