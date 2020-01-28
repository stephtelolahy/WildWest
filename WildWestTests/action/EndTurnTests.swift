//
//  EndTurnTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class EndTurnTests: XCTestCase {
    
    func test_CanEndTurn_IfPlayingNoChallenge() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let card4 = MockCardProtocol().identified(by: "c4")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .holding(card1, card2, card3, card4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = EndTurn.match(state: mockState)
        
        // Assert
        XCTAssertEqual(actions, [EndTurn(actorId: "p1", cardsToDiscardIds: ["c3", "c4"])])
    }
    
    func test_ChangeTurnToNextPlayer_IfAPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .currentTurn(is: 0)
            .players(are: mockPlayer1, mockPlayer2)
        
        let endTurn = EndTurn(actorId: "p1", cardsToDiscardIds: [])
        
        // When
        endTurn.execute(state: mockState)
        
        // Assert
        verify(mockState).setTurn(1)
    }
    
    func test_ChangeTurnToFirstPlayer_IfLastPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .currentTurn(is: 1)
            .players(are: mockPlayer1, mockPlayer2)
        
        let endTurn = EndTurn(actorId: "p2", cardsToDiscardIds: [])
        
        // When
        endTurn.execute(state: mockState)
        
        // Assert
        verify(mockState).setTurn(0)
    }
    
    func test_DiscardExcessCards_IfEndingTurn() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: MockPlayerProtocol(), MockPlayerProtocol())
        
        let endTurn = EndTurn(actorId: "p1", cardsToDiscardIds: ["c1", "c2"])
        
        // When
        endTurn.execute(state: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).discardHand(playerId: "p1", cardId: "c2")
    }
}
