//
//  CatBalouTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 31/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class CatBalouTests: XCTestCase {
    
    func test_DiscardOtherPlayerHandCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).discardHand(playerId: "p2", cardId: "c2")
    }
    
    func test_DiscardOtherPlayerInPlayCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .inPlay)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).discardInPlay(playerId: "p2", cardId: "c2")
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
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand)
        ])
    }
    
    func test_CanPlayCatBalouToDiscardOtherInPlay_IfYourTurnAndOwnCard() {
        // Given
        let sut = CatBalouRule()
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
            .noCardsInPlay()
        
        let mockPlayer3 = MockPlayerProtocol()
            .identified(by: "p3")
            .playing(MockCardProtocol().identified(by: "c3"))
            .noCardsInHand()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer3)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p3", targetCardId: "c3", targetCardSource: .inPlay)
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
            .currentTurn(is: 0)
            .players(are: mockPlayer1)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [CatBalou], [
            CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p1", targetCardId: "c2", targetCardSource: .inPlay)
        ])
    }
}
