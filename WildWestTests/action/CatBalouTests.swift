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
    
    func test_CanPlayCatBalou_IfYourTurnAndOwnCard() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.catBalou).identified(by: "c1"))
        
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
            .noCardsInPlay()
        
        let mockPlayer3 = MockPlayerProtocol()
            .identified(by: "p3")
            .playing(MockCardProtocol().identified(by: "c3"))
            .noCardsInHand()
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        
        // When
        let actions = CatBalou.match(state: mockState)
        
        // Assert
        XCTAssertEqual(actions, [
            CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand),
            CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p3", targetCardId: "c3", targetCardSource: .inPlay)
        ])
    }
    
    func test_DiscardOtherPlayerHandCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let catBalou = CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand)
        
        // When
        catBalou.execute(state: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).discardHand(playerId: "p2", cardId: "c2")
    }
    
    func test_DiscardOtherPlayerInPlayCard_IfPlayingCatBalou() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let catBalou = CatBalou(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .inPlay)
        
        // When
        catBalou.execute(state: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).discardInPlay(playerId: "p2", cardId: "c2")
    }
}
