//
//  GainRewardOnEliminatingOutlawTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 11/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class GainRewardOnEliminatingOutlaw: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_GainReward_IfEliminatingOutlaw() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "gainRewardOnEliminatingOutlaw")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p2", offender: "p1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("gainRewardOnEliminatingOutlaw", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1"),
                                .drawDeck(player: "p1"),
                                .drawDeck(player: "p1")])
    }
    
    func test_DoNothing_IfOutlawIsEliminatedByAnotherPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "gainRewardOnEliminatingOutlaw")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
        let event = GEvent.eliminate(player: "p2", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_DoNothing_IfOutlawIsEliminatedByHimself() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "gainRewardOnEliminatingOutlaw")
            .role(is: .outlaw)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let event = GEvent.eliminate(player: "p1", offender: "p1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
