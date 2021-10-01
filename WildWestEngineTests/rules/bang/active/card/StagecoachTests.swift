//
//  StagecoachTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 02/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class StagecoachTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayStagecoach_IfHoldingCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "stagecoach")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1)
            .withDefault()
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("stagecoach", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .drawDeck(player: "p1"),
                                .drawDeck(player: "p1")])
    }
    
}
