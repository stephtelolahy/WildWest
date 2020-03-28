//
//  BangMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class BangMatcherTests: XCTestCase {
    
    private var sut: BangMatcher!
    private var mockCalculator: MockRangeCalculatorProtocol!
    
    override func setUp() {
        mockCalculator = MockRangeCalculatorProtocol()
        sut = BangMatcher(calculator: mockCalculator)
    }
    
    func test_CanPlayBang_IfYourTurnAndOwnCardAndOtherIsAtRangeOf1() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .bangsPlayed(is: 0)
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(1)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(0)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(5)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(1)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p2"),
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p3")
        ])
    }
    
    func test_CannotPlayBang_IfYourTurnAndOwnCardAndOtherIsUnreachable() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .bangsPlayed(is: 0)
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(2)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(3)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(1)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(0)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CanPlayShoot_IfOtherIsReachableUsingGunRange() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(4)
            when(mock.distance(from: "p1", to: "p3", in: state(equalTo: mockState))).thenReturn(3)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(5)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(0)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p2"),
                               GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p3")])
    }
    
    func test_CannotPlayShoot_IfReachedLimitPerTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.bang).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
            .bangsPlayed(is: 1)
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.distance(from: "p1", to: "p2", in: state(equalTo: mockState))).thenReturn(1)
            when(mock.reachableDistance(of: player(equalTo: mockPlayer1))).thenReturn(1)
            when(mock.maximumNumberOfShoots(of: player(equalTo: mockPlayer1))).thenReturn(1)
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_DiscardCardAndTriggerBangChallenge_IfPlayingBang() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .bang, targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.shoot(["p2"], .bang, "p1"))])
    }
}
