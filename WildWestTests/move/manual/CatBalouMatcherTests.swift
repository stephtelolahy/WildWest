//
//  CatBalouMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CatBalouMatcherTests: XCTestCase {
    
    private var sut: CatBalouMatcher!
    private var mockCalculator: MockRangeCalculatorProtocol!
    
    override func setUp() {
        mockCalculator = MockRangeCalculatorProtocol()
        sut = CatBalouMatcher(calculator: mockCalculator)
    }
    
    func test_CanPlayCatBalouToDiscardOtherHand_IfYourTurnAndOwnCard() {
        // Given
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
        XCTAssertEqual(moves, [
            GameMove(name: .playCard, actorId: "p1", cardId: "c1", cardName: .catBalou, targetCard: TargetCard(ownerId: "p2", source: .randomHand))
        ])
    }
    
    func test_CanPlayCatBalouToDiscardOtherInPlay_IfYourTurnAndOwnCard() {
        // Given
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
        XCTAssertEqual(moves, [
            GameMove(name: .playCard, actorId: "p1", cardId: "c1", cardName: .catBalou, targetCard: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        ])
    }
    
    func test_CannotPlayCatBalou_IfNoCardsToDiscard() {
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
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
}
