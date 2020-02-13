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
    
    func test_DiscardAllCards_IfPlayerEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2").role(is: .renegade)
        let mockDeck = MockDeckProtocol().withEnabledDefaultImplementation(DeckProtocolStub())
        
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let card4 = MockCardProtocol().identified(by: "c4")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.hand.get).thenReturn([card1, card2])
            when(mock.inPlay.get).thenReturn([card3, card4])
            when(mock.removeHandById("c1")).thenReturn(card1)
            when(mock.removeHandById("c2")).thenReturn(card2)
            when(mock.removeInPlayById("c3")).thenReturn(card3)
            when(mock.removeInPlayById("c4")).thenReturn(card4)
        }
        // Given
        let sut = GameState(players: [mockPlayer1, mockPlayer2],
                            deck: mockDeck,
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
        verify(mockPlayer1).removeHandById("c1")
        verify(mockPlayer1).removeHandById("c2")
        verify(mockPlayer1).removeInPlayById("c3")
        verify(mockPlayer1).removeInPlayById("c4")
        verify(mockDeck).addToDiscard(card(identifiedBy: "c1"))
        verify(mockDeck).addToDiscard(card(identifiedBy: "c2"))
        verify(mockDeck).addToDiscard(card(identifiedBy: "c3"))
        verify(mockDeck).addToDiscard(card(identifiedBy: "c4"))
        verifyNoMoreInteractions(mockDeck)
        XCTAssertEqual(sut.eliminated.map { $0.identifier }, ["p1"])
        XCTAssertEqual(sut.players.map { $0.identifier }, ["p2"])
    }
    
    func test_KeepTurnPlayer_IfAnotherIsEliminated() {
        // Given
        let mockPlayers = [
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1").role(is: .sheriff),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2").role(is: .renegade),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3").role(is: .deputy),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4").role(is: .outlaw)
        ]
        let sut = GameState(players: mockPlayers,
                            deck: MockDeckProtocol(),
                            turn: "p4",
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
        XCTAssertEqual(sut.players.map { $0.identifier }, ["p1", "p3", "p4"])
        XCTAssertEqual(sut.turn, "p4")
    }
    
    func test_EndTurn_IfTurnPlayerIsEliminated() {
        // Given
        let mockPlayers = [
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1").role(is: .sheriff),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2").role(is: .renegade),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3").role(is: .deputy),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4").role(is: .outlaw)
        ]
        let sut = GameState(players: mockPlayers,
                            deck: MockDeckProtocol(),
                            turn: "p2",
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
        XCTAssertEqual(sut.players.map { $0.identifier }, ["p1", "p3", "p4"])
        XCTAssertEqual(sut.turn, "p3")
        XCTAssertEqual(sut.challenge, .startTurn)
    }
    
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
