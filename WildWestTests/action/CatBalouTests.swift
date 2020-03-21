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
    
    func test_CatBalouSpecificInPlayCardDescription() {
        // Given
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 to discard c2 from p2")
    }
    
    func test_CatBalouRandomHandCardDescription() {
        // Given
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .randomHand))
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 to discard random hand card from p2")
    }
    
    func test_DiscardOtherPlayerHandCard_IfPlayingCatBalou() {
        // Given
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer2)
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .randomHand))
        
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
        let sut = CatBalou(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
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
            .holding(MockCardProtocol())
            .noCardsInPlay()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .randomHand))
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
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .inPlay("c2")))
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
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
