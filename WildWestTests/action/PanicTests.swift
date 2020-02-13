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
    
    func test_PanicDescription() {
        // Given
        let sut = Panic(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .hand))
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 to take c2 from p2's hand")
    }
    
    func test_PullOtherPlayerHandCard_IfPlayingPanic() {
        // Given
        let mockState = MockGameStateProtocol()
        let sut = Panic(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .hand))
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerPullFromOtherHand("p1", "p2", "c2")
        ])
    }
    
    func test_PullOtherPlayerInPlayCard_IfPlayingPanic() {
        // Given
        let mockState = MockGameStateProtocol()
        let sut = Panic(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .inPlay))
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerPullFromOtherInPlay("p1", "p2", "c2")
        ])
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
        XCTAssertEqual(actions as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p2", source: .hand)),
            Panic(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c3", ownerId: "p3", source: .inPlay))
        ])
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
        XCTAssertEqual(actions as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", target: DiscardableCard(cardId: "c2", ownerId: "p1", source: .inPlay))
        ])
    }
}
