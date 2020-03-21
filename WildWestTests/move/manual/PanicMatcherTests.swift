//
//  PanicMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class PanicMatcherTests: XCTestCase {
    
    private var sut: PanicMatcher!
    private var mockCalculator: MockRangeCalculatorProtocol!
    
    override func setUp() {
        mockCalculator = MockRangeCalculatorProtocol()
        sut = PanicMatcher(calculator: mockCalculator)
    }
    
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
        
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
            when(mock.distance(from: "p1", to: "p3", in: any())).thenReturn(0)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name:.playCard, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p2", source: .randomHand)),
            GameMove(name: .playCard, actorId: "p1", cardId: "c1", cardName: .panic, targetCard: TargetCard(ownerId: "p3", source: .inPlay("c3")))
        ])
    }
    
    func test_CannotPlayPanic_IfTargetPlayerDistanceIsGreaterThan1() {
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
        
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(2)
            when(mock.distance(from: "p1", to: "p3", in: any())).thenReturn(3)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
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
        
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
}
