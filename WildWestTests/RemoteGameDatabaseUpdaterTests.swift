//
//  RemoteGameDatabaseUpdaterTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable file_length

import XCTest
import Firebase
import WildWestEngine
import RxSwift

class RemoteGameDatabaseUpdaterTests: XCTestCase {

    private var sut: RemoteGameDatabaseUpdaterProtocol!
    private var mockDatabaseReference: MockDatabaseReference!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        mockDatabaseReference = MockDatabaseReference()
        sut = RemoteGameDatabaseUpdater(gameRef: mockDatabaseReference)
        disposeBag = DisposeBag()
    }
    
    // MARK: - play, setTurn, setPhase
    
    func test_appendPlayedAbility_IfRun() throws {
        // Given
        let event = GEvent.run(move: GMove("a1", actor: "p1"))
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/played/1"] as? String, "a1")
            expectation.fulfill()
        }).disposed(by: disposeBag)
            
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_updateTurn_IfSetTurn() {
        // Given
        let event = GEvent.setTurn(player: "p2")
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/turn"] as? String, "p2")
            expectation.fulfill()
        }).disposed(by: disposeBag)
            
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_clearPlayedAbilities_IfSetTurn() {
        // Given
        let event = GEvent.setTurn(player: "p2")
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertNil(self.mockDatabaseReference.settedValues["state/played"])
            expectation.fulfill()
        }).disposed(by: disposeBag)
            
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_updatePhase_IfSetPhase() {
        // Given
        let event = GEvent.setPhase(value: 2)
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/phase"] as? Int, 2)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Health
    
    func test_IncrementHealth_IfGainHealth() {
        // Given
        let event = GEvent.gainHealth(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.returnedValues["state/players/p1/health"] = 1
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/players/p1/health"] as? Int, 2)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_DecrementHealth_IfLooseHealth() {
        // Given
        let event = GEvent.looseHealth(player: "p1", offender: "pX")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.returnedValues["state/players/p1/health"] = 2
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/players/p1/health"] as? Int, 1)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_SetHealthZero_IfEliminate() {
        // Given
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/players/p1/health"] as? Int, 0)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_RemovePlayerFromPlayOrder_IfEliminate() {
        // Given
        let event = GEvent.eliminate(player: "p1", offender: "p2")
        mockDatabaseReference.returnedValues["state/playOrder"] = ["p1", "p2", "p3"]
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/playOrder"] as? [String], ["p2", "p3"])
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_removeAssociatedHits_IfEliminate() {
        // Given
        let event = GEvent.eliminate(player: "p1", offender: "p2")
        let hit1 = HitDto(name: "h1", player: "p1", abilities: nil, offender: nil, cancelable: nil)
        let hit2 = HitDto(name: "h2", player: "p2", abilities: nil, offender: nil, cancelable: nil)
        mockDatabaseReference.returnedValues["state/hits"] = ["key1": hit1, "key2": hit2]
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            XCTAssertEqual(self.mockDatabaseReference.settedValues["state/hits"] as? [String: HitDto], ["key2": hit2])
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    /*
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
    */
    // MARK: - Engine
    
    func test_DoNothing_IfActivateMoves() {
        // Given
        let event = GEvent.activate(moves: [])
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
            
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_DoNothing_IfGameOver() {
        // Given
        let event = GEvent.gameover(winner: .outlaw)
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
            
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_DoNothing_IfEmptyQueue() {
        // Given
        let event = GEvent.emptyQueue
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
            
        wait(for: [expectation], timeout: 0.5)
    }
}
