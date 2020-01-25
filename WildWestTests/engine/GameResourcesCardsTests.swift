//
//  GameResourcesCardsTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameResourcesCardsTests: XCTestCase {
    
    /// TODO: define unique image for each card
    /// http://www.dvgiochi.net/bang/BANG!%20Card%20List.pdf
    

    private lazy var cards: [Card] = {
        let jsonReader = JsonReader(bundle: Bundle(for: type(of: self)))
        let sut: GameResources = GameResources(jsonReader: jsonReader)
        return sut.allCards()
    }()
    
    func test_BarrelInCardList() {
        XCTAssertTrue(cards.contains { $0.name == .barrel && $0.value == "Q" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .barrel && $0.value == "K" && $0.suit == .spades })
    }
    
    func test_DynamiteInCardList() {
        XCTAssertTrue(cards.contains { $0.name == .dynamite && $0.value == "2" && $0.suit == .hearts })
    }
    
    func test_JailInCardList() {
        XCTAssertTrue(cards.contains { $0.name == .jail && $0.value == "J" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .jail && $0.value == "4" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .jail && $0.value == "10" && $0.suit == .spades })
    }
    
    func test_MustangInCardList() {
        XCTAssertTrue(cards.contains { $0.name == .mustang && $0.value == "8" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .mustang && $0.value == "9" && $0.suit == .hearts })
    }
    
    func test_RemingtonInCardList() {
        XCTAssertTrue(cards.contains { $0.name == .remington && $0.value == "K" && $0.suit == .clubs })
    }
    
    func test_RevCarbineInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .revCarbine && $0.value == "A" && $0.suit == .clubs })
    }
    
    func test_SchofieldInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .schofield && $0.value == "J" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .schofield && $0.value == "Q" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .schofield && $0.value == "K" && $0.suit == .spades })
    }
    
    func test_ScopeInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .scope && $0.value == "A" && $0.suit == .spades })
    }
    
    func test_VolcanicInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .volcanic && $0.value == "10" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .volcanic && $0.value == "10" && $0.suit == .clubs })
    }
    
    func test_WinchesterInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .winchester && $0.value == "8" && $0.suit == .spades })
    }
    
    func test_BangInCardsList() {
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
    
    func test_BeerInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "6" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "7" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "8" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "9" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "10" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .beer && $0.value == "J" && $0.suit == .hearts })
    }
    
    func test_CatBalouInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "K" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "9" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "10" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .catBalou && $0.value == "J" && $0.suit == .diamonds })
    }
    
    func test_DuelInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .duel && $0.value == "Q" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .duel && $0.value == "J" && $0.suit == .spades })
        XCTAssertTrue(cards.contains { $0.name == .duel && $0.value == "8" && $0.suit == .clubs })
    }
    
    func test_GatlingInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .gatling && $0.value == "10" && $0.suit == .hearts })
    }
    
    func test_GeneralStoreInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .generalStore && $0.value == "9" && $0.suit == .clubs })
        XCTAssertTrue(cards.contains { $0.name == .generalStore && $0.value == "Q" && $0.suit == .spades })
    }
    
    func test_IndiansInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .indians && $0.value == "K" && $0.suit == .diamonds })
        XCTAssertTrue(cards.contains { $0.name == .indians && $0.value == "A" && $0.suit == .diamonds })
    }
    
    func test_MissedInCardsList() {
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
    
    func test_PanicInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "J" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "Q" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "A" && $0.suit == .hearts })
        XCTAssertTrue(cards.contains { $0.name == .panic && $0.value == "8" && $0.suit == .diamonds })
    }
    
    func test_SaloonInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .saloon && $0.value == "5" && $0.suit == .hearts })
    }
    
    func test_StagecoachInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .stagecoach && $0.value == "9" && $0.suit == .spades })
    }
    
    func test_WellsFargoInCardsList() {
        XCTAssertTrue(cards.contains { $0.name == .wellsFargo && $0.value == "3" && $0.suit == .hearts })
    }
    
    func test_AllCardsHaveValidImage() {
        let bundle = Bundle(for: type(of: self))
        XCTAssertTrue(cards.allSatisfy { UIImage(named: $0.imageName, in: bundle, compatibleWith: nil) != nil })
    }

}
