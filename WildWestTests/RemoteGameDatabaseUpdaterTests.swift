//
//  RemoteGameDatabaseUpdaterTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable file_length
// swiftlint:disable type_body_length

import XCTest
import Firebase
import WildWestEngine
import RxSwift
import Cuckoo

class RemoteGameDatabaseUpdaterTests: XCTestCase {
    
    private var sut: RemoteGameDatabaseUpdaterProtocol!
    private var mockDatabaseReference: MockDatabaseReferenceProtocol!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        mockDatabaseReference = MockDatabaseReferenceProtocol().withDefault()
        sut = RemoteGameDatabaseUpdater(gameRef: mockDatabaseReference)
        disposeBag = DisposeBag()
    }
    
    // MARK: - play, setTurn, setPhase
    
    func test_AppendPlayedAbility_IfRun() throws {
        // Given
        let event = GEvent.run(move: GMove("a1", actor: "p1"))
        let expectation = XCTestExpectation(description: #function)
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("key1")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/played/key1", value: any(equalTo: "a1"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_UpdateTurn_IfSetTurn() {
        // Given
        let event = GEvent.setTurn(player: "p2")
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/turn", value: any(equalTo: "p2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_ClearPlayedAbilities_IfSetTurn() {
        // Given
        let event = GEvent.setTurn(player: "p2")
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/played", value: isNil(), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_UpdatePhase_IfSetPhase() {
        // Given
        let event = GEvent.setPhase(value: 2)
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/phase", value: any(equalTo: 2), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Health
    
    func test_IncrementHealth_IfGainHealth() {
        // Given
        let event = GEvent.gainHealth(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/health", value: 1)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/health", value: any(equalTo: 2), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_DecrementHealth_IfLooseHealth() {
        // Given
        let event = GEvent.looseHealth(player: "p1", offender: "pX")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/health", value: 2)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/health", value: any(equalTo: 1), withCompletionBlock: any())
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
            verify(self.mockDatabaseReference).setValue("state/players/p1/health", value: any(equalTo: 0), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_RemovePlayerFromPlayOrder_IfEliminate() {
        // Given
        let event = GEvent.eliminate(player: "p1", offender: "p2")
        mockDatabaseReference.stubObserveSingleEvent("state/playOrder", value: ["p1", "p2", "p3"])
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/playOrder", value: any(equalTo: ["p2", "p3"]), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_removeAssociatedHits_IfEliminate() {
        // Given
        let event = GEvent.eliminate(player: "p1", offender: "p2")
        let hit1 = HitDto(player: "p1", name: nil, abilities: nil, cancelable: nil, offender: nil, target: nil)
        let hit2 = HitDto(player: "p2", name: nil, abilities: nil, cancelable: nil, offender: nil, target: nil)
        let hits = ["key1": hit1, "key2": hit2]
        mockDatabaseReference.stubObserveSingleEvent("state/hits", value: hits)
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/hits/key1", value: isNil(), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Draw
    
    func test_MoveCardFromDeckToHand_IfDrawingDeck() {
        // Given
        let event = GEvent.drawDeck(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/deck", value: ["key2": "c2", "key1": "c1", "key3": "c3"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/deck/key1", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c1"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromDeckToHand_IfDrawingDeckFlipping() {
        // Given
        let event = GEvent.drawDeckFlipping(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/deck", value: ["key2": "c2", "key1": "c1", "key3": "c3"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/deck/key1", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c1"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_ResetDeck_IfDrawingLastDeckCard() {
        // Given
        let event = GEvent.drawDeck(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/deck", value: ["key1": "c1"])
        mockDatabaseReference.stubObserveSingleEvent("state/discard", value: ["key2": "c2", "key3": "c3"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyA", "keyB")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/discard/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/deck/keyA", value: any(equalTo: "c2"), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/deck/key1", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyB", value: any(equalTo: "c1"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromHandToHand_IfDrawHand() {
        // Given
        let event = GEvent.drawHand(player: "p1", other: "p2", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p2/hand", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p2/hand/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromInPlayToHand_IfDrawInPlay() {
        // Given
        let event = GEvent.drawInPlay(player: "p1", other: "p2", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p2/inPlay", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p2/inPlay/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromStoreToHand_IfDrawStore() {
        // Given
        let event = GEvent.drawStore(player: "p1", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/store", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/store/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromDiscardToHand_IfDrawDiscard() {
        // Given
        let event = GEvent.drawDiscard(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/discard", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/discard/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - equip
    
    func test_MoveCardFromHandToInPlay_IfEquip() {
        // Given
        let event = GEvent.equip(player: "p1", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/hand", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/inPlay/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromHandToOtherInPlay_IfHandicap() {
        // Given
        let event = GEvent.handicap(player: "p1", card: "c2", other: "p2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/hand", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p2/inPlay/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromInPlayToOtherInPlay_IfPassInPlay() {
        // Given
        let event = GEvent.passInPlay(player: "p1", card: "c2", other: "p2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/inPlay", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/inPlay/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p2/inPlay/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Discard
    
    func test_MoveCardFromHandToDiscard_IfDiscardHand() {
        // Given
        let event = GEvent.discardHand(player: "p1", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/hand", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/discard/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromHandToDiscard_IfPlay() {
        // Given
        let event = GEvent.play(player: "p1", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/hand", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/discard/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromInPlayToDiscard_IfDiscardInPlay() {
        // Given
        let event = GEvent.discardInPlay(player: "p1", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/players/p1/inPlay", value: ["key1": "c1", "key2": "c2"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/players/p1/inPlay/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/discard/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Store
    
    func test_MoveFromDeckToStore_IfDeckToStore() {
        // Given
        let event = GEvent.deckToStore
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/deck", value: ["key2": "c2", "key1": "c1", "key3": "c3"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/deck/key1", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/store/keyX", value: any(equalTo: "c1"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_MoveCardFromDeckToHand_IfDrawDeckChoosing() {
        // Given
        let event = GEvent.drawDeckChoosing(player: "p1", card: "c2")
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/deck", value: ["key1": "c1", "key2": "c2", "key3": "c3"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/deck/key2", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/players/p1/hand/keyX", value: any(equalTo: "c2"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Reveal
    
    func test_MoveCardFromDeckToDiscard_IfRevealDeck() {
        // Given
        let event = GEvent.flipDeck
        let expectation = XCTestExpectation(description: #function)
        mockDatabaseReference.stubObserveSingleEvent("state/deck", value: ["key2": "c2", "key1": "c1", "key3": "c3"])
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/deck/key1", value: isNil(), withCompletionBlock: any())
            verify(self.mockDatabaseReference).setValue("state/discard/keyX", value: any(equalTo: "c1"), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Hit
    
    func test_AddHit() throws {
        // Given
        let event = GEvent.addHit(hits: [GHit(player: "p2", name: "n1", abilities: ["a1", "a2"], offender: "p1"),
                                         GHit(player: "p3", name: "n1", abilities: ["a1", "a2"], offender: "p1", cancelable: 1, target: "pX")])
        let expectation = XCTestExpectation(description: #function)
        stub(mockDatabaseReference) { mock in
            when(mock).childByAutoIdKey().thenReturn("keyX", "keyY")
        }
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            let hit1: [String: Any] = ["player": "p2",
                                       "name": "n1",
                                       "abilities": ["a1", "a2"],
                                       "offender": "p1",
                                       "cancelable": 0]
            verify(self.mockDatabaseReference).setValue("state/hits/keyX", value: any(equalToDictionary: hit1), withCompletionBlock: any())
            
            let hit2: [String: Any] = ["player": "p3",
                                       "name": "n1",
                                       "abilities": ["a1", "a2"],
                                       "offender": "p1",
                                       "cancelable": 1,
                                       "target": "pX"]
            verify(self.mockDatabaseReference).setValue("state/hits/keyY", value: any(equalToDictionary: hit2), withCompletionBlock: any())
            
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_RemoveHit() {
        // Given
        let event = GEvent.removeHit(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        let hits: [String: Any] = ["key0": ["player": "p2", "name": "n1"],
                                   "key2": ["player": "p1", "name": "n1"],
                                   "key1": ["player": "p1", "name": "n1"]]
        mockDatabaseReference.stubObserveSingleEvent("state/hits", value: hits)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/hits/key1", value: isNil(), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_CancelHit() {
        // Given
        let event = GEvent.cancelHit(player: "p1")
        let expectation = XCTestExpectation(description: #function)
        let hits: [String: Any] = ["key2": ["player": "p2", "name": "n1", "cancelable": 1],
                                   "key1": ["player": "p1", "name": "n1", "cancelable": 2]]
        mockDatabaseReference.stubObserveSingleEvent("state/hits", value: hits)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/hits/key1/cancelable", value: any(equalTo: 1), withCompletionBlock: any())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Engine
    
    func test_DoNothing_IfActivateMoves() {
        // Given
        let event = GEvent.activate(moves: [])
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verifyNoMoreInteractions(self.mockDatabaseReference)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_SetWinner_IfGameOver() {
        // Given
        let event = GEvent.gameover(winner: .outlaw)
        let expectation = XCTestExpectation(description: #function)
        
        // When
        // Assert
        sut.execute(event).subscribe(onCompleted: {
            verify(self.mockDatabaseReference).setValue("state/winner", value: any(equalTo: "outlaw"), withCompletionBlock: any())
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
            verifyNoMoreInteractions(self.mockDatabaseReference)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
    }
}
