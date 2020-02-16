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
    
    func test_PanicSpecificInPlayCardDescription() {
        // Given
        let sut = Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 to take c2 from p2")
    }
    
    func test_PanicRandomHandCardDescription() {
        // Given
        let sut = Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .randomHand))
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 to take random hand card from p2")
    }
    
    func test_PullOtherPlayerHandCard_IfPlayingPanic() {
        // Given
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer2)
        let sut = Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .randomHand))
        
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
        let sut = Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
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
        
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
            when(mock.distance(from: "p1", to: "p3", in: any())).thenReturn(0)
        }
        
        let sut = PanicRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p2", source: .randomHand)),
            Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p3", source: .inPlay("c3")))
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
        
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(2)
            when(mock.distance(from: "p1", to: "p3", in: any())).thenReturn(3)
        }
        
        let sut = PanicRule(calculator: mockCalculator)
        
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
        
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
        }
        
        let sut = PanicRule(calculator: mockCalculator)
        
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
        
        let mockCalculator = MockRangeCalculatorProtocol()
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: any())).thenReturn(1)
        }
        
        let sut = PanicRule(calculator: mockCalculator)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Panic], [
            Panic(actorId: "p1", cardId: "c1", target: TargetCard(ownerId: "p1", source: .inPlay("c2")))
        ])
    }
}
