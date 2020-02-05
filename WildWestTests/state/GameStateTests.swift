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
    
    private var sut: GameStateProtocol!
    
    private var mockPlayer1: MockPlayerProtocol!
    private var mockPlayer2: MockPlayerProtocol!
    private var mockDeck: MockDeckProtocol!
    
    override func setUp() {
        mockDeck = MockDeckProtocol()
            .withEnabledDefaultImplementation(DeckProtocolStub())
        mockPlayer1 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p1")
        mockPlayer2 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p2")
        sut = GameState(players: [mockPlayer1, mockPlayer2],
                        deck: mockDeck,
                        turn: 0,
                        challenge: nil,
                        turnShoots: 0,
                        generalStoreCards: [],
                        outcome: nil,
                        actions: [],
                        commands: [],
                        eliminated: [])
    }
    
    func test_InitialProperties() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.players.map { $0.identifier }, ["p1", "p2"])
        XCTAssertTrue(sut.deck as? MockDeckProtocol === mockDeck)
        XCTAssertEqual(sut.turn, 0)
        XCTAssertNil(sut.challenge)
        XCTAssertEqual(sut.turnShoots, 0)
        XCTAssertTrue(sut.generalStoreCards.isEmpty)
        XCTAssertNil(sut.outcome)
        XCTAssertTrue(sut.commands.isEmpty)
        XCTAssertTrue(sut.eliminated.isEmpty)
    }
    
    func test_MoveCardFromDeckToActorsHand_IfPulling() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockDeck) { mock in
            when(mock.pull()).thenReturn(card1)
        }
        
        // When
        sut.pullDeck(playerId: "p1")
        
        // Assert
        verify(mockDeck).pull()
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).addHand(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_MoveCardFromHandToDiscard_IfDiscardingHand() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.removeHandById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardHand(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).removeHandById("c1")
        verify(mockDeck).addToDiscard(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_MoveCardFromInPlayToDiscard_IfDiscardingInPlay() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.removeInPlayById("c1")).thenReturn(card1)
        }
        
        // When
        sut.discardInPlay(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).removeInPlayById("c1")
        verify(mockDeck).addToDiscard(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockDeck)
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_IncrementHealth_IfGainingLifePoint() {
        // Given
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.health.get).thenReturn(2)
        }
        
        // When
        sut.gainLifePoint(playerId: "p1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).health.get()
        verify(mockPlayer1).setHealth(3)
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_MoveCardFromHandToInPlay_ifPuttingInPlay() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.removeHandById("c1")).thenReturn(card1)
        }
        
        // When
        sut.putInPlay(playerId: "p1", cardId: "c1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).removeHandById("c1")
        verify(mockPlayer1).addInPlay(card(identifiedBy: "c1"))
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_SetTurn() {
        // Given
        // When
        sut.setTurn(1)
        
        // Assert
        XCTAssertEqual(sut.turn, 1)
    }
    
    func test_SetTurnShoots() {
        // Given
        // When
        sut.setTurnShoots(1)
        
        // Assert
        XCTAssertEqual(sut.turnShoots, 1)
    }
    
    func test_AddCommand() {
        // Given
        let action1 = MockActionProtocol().described(by: "a1")
        let action2 = MockActionProtocol().described(by: "a2")
        
        // When
        sut.addCommand(action1)
        sut.addCommand(action2)
        
        // Assert
        XCTAssertEqual(sut.commands.map { $0.description }, ["a1", "a2"])
    }
    
    func test_SetChallenge() {
        // Given
        // When
        sut.setChallenge(.startTurn)
        
        // Assert
        XCTAssertEqual(sut.challenge, .startTurn)
    }
    
    func test_RemoveChallenge() {
        // Given
        // When
        sut.setChallenge(nil)
        
        // Assert
        XCTAssertNil(sut.challenge)
    }
    
    func test_SetActions() {
        // Given
        // When
        sut.setActions([GenericAction(name: "ac", actorId: "p1", cardId: "c1", options: [])])
        
        // Assert
        XCTAssertEqual(sut.actions.count, 1)
        XCTAssertEqual(sut.actions[0].name, "ac")
        XCTAssertEqual(sut.actions[0].cardId, "c1")
        XCTAssertEqual(sut.actions[0].actorId, "p1")
        XCTAssertTrue(sut.actions[0].options.isEmpty)
    }
    
    func test_AddCardToHand_IfPullingOtherHand() {
        // Given
        Cuckoo.stub(mockPlayer2) { mock in
            when(mock.removeHandById("c2")).thenReturn(MockCardProtocol().identified(by: "c2"))
        }
        
        // When
        sut.pullHand(playerId: "p1", otherId: "p2", cardId: "c2")
        
        // Assert
        verify(mockPlayer1, atLeastOnce()).identifier.get()
        verify(mockPlayer2, atLeastOnce()).identifier.get()
        verify(mockPlayer2).removeHandById("c2")
        verify(mockPlayer1).addHand(card(identifiedBy: "c2"))
        verifyNoMoreInteractions(mockPlayer1)
        verifyNoMoreInteractions(mockPlayer2)
    }
    
    func test_AddCardToHand_IfPullingOtherInPlay() {
        // Given
        Cuckoo.stub(mockPlayer2) { mock in
            when(mock.removeInPlayById("c2")).thenReturn(MockCardProtocol().identified(by: "c2"))
        }
        
        // When
        sut.pullInPlay(playerId: "p1", otherId: "p2", cardId: "c2")
        
        // Assert
        verify(mockPlayer1, atLeastOnce()).identifier.get()
        verify(mockPlayer2, atLeastOnce()).identifier.get()
        verify(mockPlayer2).removeInPlayById("c2")
        verify(mockPlayer1).addHand(card(identifiedBy: "c2"))
        verifyNoMoreInteractions(mockPlayer1)
        verifyNoMoreInteractions(mockPlayer2)
    }
    
    func test_DecrementHealth_IfLoosingLifePoint() {
        // Given
        Cuckoo.stub(mockPlayer1) { mock in
            when(mock.health.get).thenReturn(2)
        }
        
        // When
        sut.looseLifePoint(playerId: "p1")
        
        // Assert
        verify(mockPlayer1).identifier.get()
        verify(mockPlayer1).health.get()
        verify(mockPlayer1).setHealth(1)
        verifyNoMoreInteractions(mockPlayer1)
    }
    
    func test_RevealRoleAndDiscardAllCards_IfPlayerEliminated() {
        // Given
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
        let players: [PlayerProtocol] = [
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p1"),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p2"),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p3"),
            MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub()).identified(by: "p4")
        ]
        sut = GameState(players: players,
                        deck: mockDeck,
                        turn: 3, // turn player is "p4"
            challenge: nil,
            turnShoots: 0,
            generalStoreCards: [],
            outcome: nil,
            actions: [],
            commands: [],
            eliminated: [])
        
        // When
        sut.eliminate(playerId: "p2")
        
        // Assert
        XCTAssertEqual(sut.players.map { $0.identifier }, ["p1", "p3", "p4"])
        XCTAssertEqual(sut.turn, 2) // turn player is still "p4"
    }
    
    func test_SetGeneralStoreCards() {
        // Given
        Cuckoo.stub(mockDeck) { mock in
            when(mock.pull()).thenReturn(MockCardProtocol().identified(by: "c1"),
                                         MockCardProtocol().identified(by: "c2"),
                                         MockCardProtocol().identified(by: "c3"))
        }
        // When
        sut.setupGeneralStore(count: 3)
        
        // Assert
        XCTAssertEqual(sut.generalStoreCards.map { $0.identifier }, ["c1", "c2", "c3"])
    }
    
    func test_PullCardFromGeneralStore() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        sut = GameState(players: [mockPlayer1, mockPlayer2],
                    deck: mockDeck,
                    turn: 0,
                    challenge: .generalStore(["p1", "p2"]),
                    turnShoots: 0,
                    generalStoreCards: [card1, card2],
                    outcome: nil,
                    actions: [],
                    commands: [],
                    eliminated: [])
        
        // When
        sut.pullGeneralStore(playerId: "p1", cardId: "c1")
        
        // Aseert
        XCTAssertEqual(sut.generalStoreCards.map { $0.identifier }, ["c2"])
        verify(mockPlayer1).addHand(card(identifiedBy: "c1"))
    }
    
    func test_EndTurn_IfTurnPlayerIsEliminated() {
        #warning("TODO: implement after integrating Duel, Dynamite")
    }
    
    func test_EndGame_IfSheriffIsEliminated() {
        #warning("TODO: implement after completing rules")
    }
    
    func test_EndGame_IfAllOutlawsAreEliminated() {
        #warning("TODO: implement after completing rules")
    }
    
    func test_RewardActor_IfAnOutlawIsEliminated() {
        #warning("TODO: implement after completing rules")
    }
}
