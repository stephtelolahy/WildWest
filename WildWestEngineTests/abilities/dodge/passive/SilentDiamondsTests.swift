//
//  SilentDiamondsTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 08/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class SilentDiamondsTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()

    func test_CannotPlayDiamondCard_IfTargetHasSilentDiamonds() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "bang")
            .suit(is: "♦️")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .attributes(are: [.silentCard: "♦️"])
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
