//
//  GameStateTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameStateTests: XCTestCase {
    
    func test_OutlawWins_IfSheriffIsEliminated() {
        // Given
        let mockPlayers = [
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1").role(is: .sheriff),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2").role(is: .renegade),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3").role(is: .deputy),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4").role(is: .outlaw)
        ]
        let sut = GameState(players: mockPlayers,
                            deck: MockDeckProtocol(),
                            turn: "p1",
                            challenge: nil,
                            bangsPlayed: 0,
                            generalStoreCards: [],
                            outcome: nil,
                            actions: [],
                            commands: [],
                            eliminated: [])
        
        // When
        sut.eliminate(playerId: "p1")
        
        // Assert
        XCTAssertEqual(sut.outcome, .outlawWin)
    }
    
    func test_RenegateWins_IfSheriffIsLastEliminated() {
        // Given
        let mockPlayers = [
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1").role(is: .sheriff),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2").role(is: .renegade)
        ]
        let sut = GameState(players: mockPlayers,
                            deck: MockDeckProtocol(),
                            turn: "p1",
                            challenge: nil,
                            bangsPlayed: 0,
                            generalStoreCards: [],
                            outcome: nil,
                            actions: [],
                            commands: [],
                            eliminated: [])
        
        // When
        sut.eliminate(playerId: "p1")
        
        // Assert
        XCTAssertEqual(sut.outcome, .renegadeWin)
    }
    
    func test_SheriffWins_IfAllOutlawsAreEliminated() {
        // Given
        let mockPlayers = [
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1").role(is: .sheriff),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2").role(is: .renegade),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3").role(is: .deputy)
        ]
        let sut = GameState(players: mockPlayers,
                            deck: MockDeckProtocol(),
                            turn: "p1",
                            challenge: nil,
                            bangsPlayed: 0,
                            generalStoreCards: [],
                            outcome: nil,
                            actions: [],
                            commands: [],
                            eliminated: [])
        
        // When
        sut.eliminate(playerId: "p2")
        
        // Assert
        XCTAssertEqual(sut.outcome, .sheriffWin)
    }
}
