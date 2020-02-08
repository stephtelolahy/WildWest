//
//  PanicTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 31/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Panic!
 The symbols state: “Draw
 a card” from “a player at
 distance 1”. Remember that this distance is not modified by
 weapons, but only by cards such as Mustang and/or Scope.
 */
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
        verifyNoMoreInteractions(mockState)
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
        verifyNoMoreInteractions(mockState)
    }
}

class PanicRuleTests: XCTestCase {
    
    func test_CanPlayPanic_IfYourTurnAndOwnCardAndDistanceIs1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
            .noCardsInPlay()
        
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
            .currentTurn(is: "p1")
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
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "panic")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p2", targetCardId: "c2", targetCardSource: .hand),
            Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p3", targetCardId: "c3", targetCardSource: .inPlay)
        ])
        XCTAssertEqual(actions?[0].options.map { $0.description }, [
            "p1 plays c1 to discard c2 from p2's hand",
            "p1 plays c1 to discard c3 from p3's inPlay"])
    }
    
    func test_CannotPlayPanic_IfOtherCardsAreMoreThan1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
            .noCardsInPlay()
        
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
            .currentTurn(is: "p1")
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
        XCTAssertNil(actions)
    }
    
    func test_CannotPlayPanic_IfNoCardsToDiscard() {
        // Given
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
        
        let mockRangeCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockRangeCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
        }
        
        let sut = PanicRule(calculator: mockRangeCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CanPlayPanicToDiscardSelfInPlayCard_IfYourTurnAndOwnCard() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.panic).identified(by: "c1"))
            .playing(MockCardProtocol().identified(by: "c2"))
        
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1)
        
        let mockRangeCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockRangeCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
        }
        
        let sut = PanicRule(calculator: mockRangeCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "panic")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", targetPlayerId: "p1", targetCardId: "c2", targetCardSource: .inPlay)
        ])
        XCTAssertEqual(actions?[0].options[0].description, "p1 plays c1 to discard c2 from p1's inPlay")
    }
}
