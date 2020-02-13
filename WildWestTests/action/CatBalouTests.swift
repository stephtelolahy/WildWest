//
//  CatBalouTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 31/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Cat Balou
 Force “any one player” to “discard a card”, regardless of
 the distance
 */
class CatBalouTests: XCTestCase {
    
    func test_CatBalouDescription() {
        // Given
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .hand))
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 to discard c2 from p2's hand")
    }
    
    func test_DiscardOtherPlayerHandCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol()
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .hand))
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerDiscardHand("p2", "c2")
        ])
    }
    
    func test_DiscardOtherPlayerInPlayCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol()
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .inPlay))
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerDiscardInPlay("p2", "c2")
        ])
    }
}

class CatBalouRuleTests: XCTestCase {
    
    func test_CanPlayCatBalouToDiscardOtherHand_IfYourTurnAndOwnCard() {
        // Given
        let sut = CatBalouRule()
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
            .noCardsInPlay()
        
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
            .noCardsInPlay()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .hand))
        ])
    }
    
    func test_CanPlayCatBalouToDiscardOtherInPlay_IfYourTurnAndOwnCard() {
        // Given
        let sut = CatBalouRule()
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
            .noCardsInPlay()
        
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .playing(MockCardProtocol().identified(by: "c2"))
            .noCardsInHand()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .inPlay))
        ])
    }
    
    func test_CanPlayCatBalouToDiscardSelfInPlayCard_IfYourTurnAndOwnCard() {
        // Given
        let sut = CatBalouRule()
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
            .playing(MockCardProtocol().identified(by: "c2"))
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p1", source: .inPlay))
        ])
    }
    
    func test_CannotPlayCatBalou_IfNoCardsToDiscard() {
        // Given
        let sut = CatBalouRule()
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
            .noCardsInPlay()
        
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .noCardsInHand()
            .noCardsInPlay()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
