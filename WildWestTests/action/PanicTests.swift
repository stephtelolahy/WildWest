//
//  PanicTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 31/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class PanicTests: XCTestCase {
    
    func test_PullOtherPlayerHandCard_IfPlayingPanic() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).pullHand(playerId: "p1", otherId: "p2", cardId: "c2")
    }
    
    func test_PullOtherPlayerInPlayCard_IfPlayingPanic() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .inPlay)
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).pullInPlay(playerId: "p1", otherId: "p2", cardId: "c2")
    }
}

class PanicRuleTests: XCTestCase {
    
    func test_CanPlayPanic_IfYourTurnAndOwnCardAndDistanceIs1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
        
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
        
        let mockRangeCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockRangeCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
            when(mock.distance(from: "p1", to: "p3", in: any())).thenReturn(0)
        }
        
        let sut = PanicRule(calculator: mockRangeCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand),
            Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p3", targetCardId: "c3", targetCardSource: .inPlay)
        ])
    }
    
    func test_CannotPlayPanic_IfYourTurnAndOwnCardAndDistanceIsMoreThan1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
        
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
        
        let mockRangeCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockRangeCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(2)
            when(mock.distance(from: "p1", to: "p3", in: any())).thenReturn(3)
        }
        
        let sut = PanicRule(calculator: mockRangeCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertTrue(actions.isEmpty)
    }
    
}
