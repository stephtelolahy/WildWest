//
//  ResolveJailTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class ResolveJailTests: XCTestCase {
    
    func test_ResolveJainDescription() {
        // Given
        let sut = ResolveJail(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 resolves c1")
    }
    
    func test_DiscardJail_AfterResolve() {
        XCTFail()
    }
    
    
    func test_StartTurn_IfReturnHeartFromDeck() {
        XCTFail()
    }
    
    func test_SkipTurn_IfReturnNonHeartFromDeck() {
        XCTFail()
    }
}

class ResolveJailRuleTests: XCTestCase {
    
    func test_ShouldResolveJail_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .challenge(is: .startTurn)
            .currentTurn(is: "p1")
        let sut = ResolveJailRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "resolve jail")
        XCTAssertNil(actions?[0].cardId)
        XCTAssertEqual(actions?[0].options as? [ResolveJail], [ResolveJail(actorId: "p1", cardId: "c1")])
    }
}
