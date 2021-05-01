//
//  GDatabaseUpdaterTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 14/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable type_body_length
// swiftlint:disable file_length

import XCTest
import WildWestEngine

class GDatabaseUpdaterTests: XCTestCase {

    private var sut: GDatabaseUpdaterProtocol!
    
    override func setUp() {
        sut = GDatabaseUpdater()
    }
    
    // MARK: - play, setTurn, setPhase
    
    func test_Run() {
        // Given
        let mockState = MockStateProtocol()
            .withDefault()
            .played(are: "a1")
        let state = GState(mockState)
        let event = GEvent.run(move: GMove("a2", actor: "p1"))
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.played, ["a1", "a2"])
    }
    
    func test_setTurn() {
        // Given
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .played(are: "a1")
        let state = GState(mockState)
        let event = GEvent.setTurn(player: "p2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.turn, "p2")
        XCTAssertEqual(state.played, [])
    }
    
    func test_setPhase() {
        // Given
        let mockState = MockStateProtocol()
            .withDefault()
            .phase(is: 1)
        let state = GState(mockState)
        let event = GEvent.setPhase(value: 2)
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.phase, 2)
    }
    
    // MARK: - Health
    
    func test_IncrmentHealth_IfGainHealth() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let state = GState(mockState)
        let event = GEvent.gainHealth(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.health, 3)
    }
    
    func test_DecrementHealth_IfLooseHealth() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let state = GState(mockState)
        let event = GEvent.looseHealth(player: "p1", offender: "pX")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.health, 1)
    }
    
    func test_SetHealthZero_IfEliminate() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1", "p2", "p3")
        let state = GState(mockState)
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.health, 0)
    }
    
    func test_RemovePlayerFromPlayOrder_IfEliminate() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1", "p2", "p3")
        let state = GState(mockState)
        let event = GEvent.eliminate(player: "p1", offender: "p2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.playOrder, ["p2", "p3"])
    }
    
    func test_removeAssociatedHits_IfEliminate() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1", "p2", "p3")
            .hits(are: MockHitProtocol().withDefault().player(is: "p1"))
        let state = GState(mockState)
        let event = GEvent.eliminate(player: "p1", offender: "p2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.playOrder, ["p2", "p3"])
        XCTAssertEqual(state.hits.count, 0)
    }
    
    // MARK: - Draw
    
    func test_AddCardToHand_IfDrawingDeck() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .deck(are: mockCard2, mockCard3)
        let state = GState(mockState)
        let event = GEvent.drawDeck(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(state.deck.map { $0.identifier }, ["c3"])
    }
    
    func test_ResetDeck_IfDrawingLastDeckCard() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .deck(are: mockCard1)
            .discard(are: mockCard2, mockCard3)
        let state = GState(mockState)
        let event = GEvent.drawDeck(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1"])
        XCTAssertEqual(state.deck.map { $0.identifier }, ["c3"])
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c2"])
    }
    
    func test_ResetDeck_IfDrawingCardWhileDeckId2() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockCard4 = MockCardProtocol().withDefault().identified(by: "c4")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .deck(are: mockCard1, mockCard4)
            .discard(are: mockCard2, mockCard3)
        let state = GState(mockState)
        let event = GEvent.drawDeck(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1"])
        XCTAssertEqual(state.deck.map { $0.identifier }, ["c4", "c3"])
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c2"])
    }
    
    func test_drawHand() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
        let state = GState(mockState)
        let event = GEvent.drawHand(player: "p1", other: "p2", card: "c2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(state.players["p2"]!.hand.map { $0.identifier }, [])
    }
    
    func test_drawInPlay() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(mockCard2, mockCard3)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
        let state = GState(mockState)
        let event = GEvent.drawInPlay(player: "p1", other: "p2", card: "c2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(state.players["p2"]!.inPlay.map { $0.identifier }, ["c3"])
    }
    
    func test_drawStore() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .store(are: mockCard2, mockCard3)
        let state = GState(mockState)
        let event = GEvent.drawStore(player: "p1", card: "c2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(state.store.map { $0.identifier }, ["c3"])
    }
    
    func test_drawDiscard() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .discard(are: mockCard2, mockCard3)
        let state = GState(mockState)
        let event = GEvent.drawDiscard(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c3"])
    }
    
    // MARK: - equip
    
    func test_equip() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let state = GState(mockState)
        let event = GEvent.equip(player: "p1", card: "c1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.inPlay.map { $0.identifier }, ["c1"])
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c2"])
    }
    
    func test_handicap() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
        let state = GState(mockState)
        let event = GEvent.handicap(player: "p1", card: "c1", other: "p2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p2"]!.inPlay.map { $0.identifier }, ["c2", "c1"])
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, [])
    }
    
    func test_passInPlay() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(mockCard2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
        let state = GState(mockState)
        let event = GEvent.passInPlay(player: "p1", card: "c1", other: "p2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p2"]!.inPlay.map { $0.identifier }, ["c2", "c1"])
        XCTAssertEqual(state.players["p1"]!.inPlay.map { $0.identifier }, [])
    }
    
    // MARK: - Discard
    
    func test_discardHand() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .discard(are: mockCard2)
        let state = GState(mockState)
        let event = GEvent.discardHand(player: "p1", card: "c1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, [])
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c1", "c2"])
    }
    
    func test_Play() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .discard(are: mockCard2)
        let state = GState(mockState)
        let event = GEvent.play(player: "p1", card: "c1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, [])
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c1", "c2"])
    }
    
    func test_discardInPlay() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .discard(are: mockCard2)
        let state = GState(mockState)
        let event = GEvent.discardInPlay(player: "p1", card: "c1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.inPlay.map { $0.identifier }, [])
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c1", "c2"])
    }
    
    // MARK: - Store
    
    func test_setStoreView() {
        // Given
        let mockState = MockStateProtocol().withDefault()
        let state = GState(mockState)
        let event = GEvent.setStoreView(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.storeView, "p1")
    }
    
    func test_deckToStore() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockState = MockStateProtocol()
            .withDefault()
            .deck(are: mockCard1, mockCard2)
        let state = GState(mockState)
        let event = GEvent.deckToStore
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.store.map { $0.identifier }, ["c1"])
        XCTAssertEqual(state.deck.map { $0.identifier }, ["c2"])
    }
    
    func test_storeToDeck() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockState = MockStateProtocol()
            .withDefault()
            .deck(are: mockCard1)
            .store(are: mockCard2)
        let state = GState(mockState)
        let event = GEvent.storeToDeck(card: "c2")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.store.map { $0.identifier }, [])
        XCTAssertEqual(state.deck.map { $0.identifier }, ["c2", "c1"])
    }
    
    // MARK: - Reveal
    
    func test_revealDeck() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockCard3 = MockCardProtocol().withDefault().identified(by: "c3")
        let mockState = MockStateProtocol()
            .withDefault()
            .deck(are: mockCard1, mockCard2)
            .discard(are: mockCard3)
        let state = GState(mockState)
        let event = GEvent.revealDeck
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.discard.map { $0.identifier }, ["c1", "c3"])
        XCTAssertEqual(state.deck.map { $0.identifier }, ["c2"])
    }
    
    func test_DoNothing_IfRevealHand() {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let state = GState(mockState)
        let event = GEvent.revealHand(player: "p1", card: "c1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.players["p1"]!.hand.map { $0.identifier }, ["c1"])
    }
    
    // MARK: - Hit
    
    func test_addHit() throws {
        // Given
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
        let state = GState(mockState)
        let event = GEvent.addHit(name: "n1", player: "p2", abilities: ["looseHealth"], cancelable: 1, offender: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.hits.count, 2)
        XCTAssertEqual(state.hits[0].player, "p1")
        XCTAssertEqual(state.hits[1].player, "p2")
        XCTAssertEqual(state.hits[1].abilities, ["looseHealth"])
        XCTAssertEqual(state.hits[1].cancelable, 1)
        XCTAssertEqual(state.hits[1].offender, "p1")
    }
    
    func test_removeHit() {
        // Given
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
        let mockHit2 = MockHitProtocol()
            .withDefault()
            .player(is: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1, mockHit2)
        let state = GState(mockState)
        let event = GEvent.removeHit(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.hits.count, 1)
        XCTAssertEqual(state.hits[0].player, "p2")
    }
    
    func test_editHit() {
        // Given
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 2)
        let mockHit2 = MockHitProtocol()
            .withDefault()
            .player(is: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1, mockHit2)
        let state = GState(mockState)
        let event = GEvent.cancelHit(player: "p1")
        
        // When
        sut.execute(event, in: state)
        
        // Assert
        XCTAssertEqual(state.hits.count, 2)
        XCTAssertEqual(state.hits[0].player, "p1")
        XCTAssertEqual(state.hits[0].cancelable, 1)
        XCTAssertEqual(state.hits[1].player, "p2")
    }
    
    // MARK: - Engine
    
    func test_DoNothing_IfActivateMoves() {
        // Given
        let mockState = MockStateProtocol()
            .withDefault()
        let state = GState(mockState)
        let event = GEvent.activate(moves: [])
        
        // When
        // Assert
        XCTAssertNoThrow(sut.execute(event, in: state))
    }
    
    func test_DoNothing_IfGameOver() {
        // Given
        let mockState = MockStateProtocol()
            .withDefault()
        let state = GState(mockState)
        let event = GEvent.gameover(winner: .outlaw)
        
        // When
        // Assert
        XCTAssertNoThrow(sut.execute(event, in: state))
    }
    
    func test_DoNothing_IfEmptyQueue() {
        // Given
        let mockState = MockStateProtocol()
            .withDefault()
        let state = GState(mockState)
        let event = GEvent.emptyQueue
        
        // When
        // Assert
        XCTAssertNoThrow(sut.execute(event, in: state))
    }
}
