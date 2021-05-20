//
//  DtoEncodingTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Cuckoo

class DtoEncodingTests: XCTestCase {
    
    private var sut: DtoEncoder!
    private var mockCard1: CardProtocol!
    private var mockCard2: CardProtocol!
    private var mockCard3: CardProtocol!
    private var mockCard4: CardProtocol!
    private var mockDatabaseReference: MockDatabaseReferenceProtocol!
    
    override func setUp() {
        mockCard1 = GCard(identifier: "c1", name: "", type: .blue, desc: "", abilities: [:], suit: "", value: "")
        mockCard2 = GCard(identifier: "c2", name: "", type: .blue, desc: "", abilities: [:], suit: "", value: "")
        mockCard3 = GCard(identifier: "c3", name: "", type: .blue, desc: "", abilities: [:], suit: "", value: "")
        mockCard4 = GCard(identifier: "c4", name: "", type: .blue, desc: "", abilities: [:], suit: "", value: "")
        mockDatabaseReference = MockDatabaseReferenceProtocol()
        sut = DtoEncoder(databaseRef: mockDatabaseReference, allCards: [mockCard1, mockCard2, mockCard3, mockCard4])
    }
    
    // MARK: - State
    
    func test_StateEncoding() throws {
        // Given
        let player1 = GPlayer(identifier: "p1",
                              name: "name1",
                              desc: "desc1",
                              abilities: ["ab1": 0, "ab2": 1],
                              role: .sheriff,
                              maxHealth: 4,
                              health: 2,
                              hand: [],
                              inPlay: [])
        let hit1 = GHit(player: "p1",
                        name: "hit1",
                        abilities: ["ab1"],
                        cancelable: 1,
                        offender: "p2")
        let state = GState(players: ["p1": player1],
                           initialOrder: ["p1", "p2"],
                           playOrder: ["p2", "p1"],
                           turn: "p2",
                           phase: 3,
                           deck: [mockCard1, mockCard2],
                           discard: [mockCard3, mockCard4],
                           store: [],
                           hits: [hit1],
                           played: ["bang"])
        
        stub(mockDatabaseReference) { mock in
            when(mock.childByAutoIdKey()).thenReturn("key1", "key2", "key3", "key4")
        }
        
        // When
        let encoded = sut.encode(state: state)
        let decoded = try sut.decode(state: encoded)
        
        // Assert
        XCTAssertEqual(decoded.players.count, 1)
        XCTAssertEqual(decoded.initialOrder, ["p1", "p2"])
        XCTAssertEqual(decoded.playOrder, ["p2", "p1"])
        XCTAssertEqual(decoded.turn, "p2")
        XCTAssertEqual(decoded.phase, 3)
        XCTAssertEqual(decoded.deck.map { $0.identifier }, ["c1", "c2"])
        XCTAssertEqual(decoded.discard.map { $0.identifier }, ["c3", "c4"])
        XCTAssertEqual(decoded.store.map { $0.identifier }, [])
        XCTAssertEqual(decoded.hits.count, 1)
        XCTAssertEqual(decoded.played, ["bang"])
        
        let decodedPlayer1 = try XCTUnwrap(decoded.players["p1"])
        XCTAssertEqual(decodedPlayer1.identifier, "p1")
        XCTAssertEqual(decodedPlayer1.name, "name1")
        XCTAssertEqual(decodedPlayer1.desc, "desc1")
        XCTAssertEqual(decodedPlayer1.abilities, ["ab1": 0, "ab2": 1])
        XCTAssertEqual(decodedPlayer1.role, .sheriff)
        XCTAssertEqual(decodedPlayer1.maxHealth, 4)
        XCTAssertEqual(decodedPlayer1.health, 2)
        XCTAssertEqual(decodedPlayer1.hand.map { $0.identifier }, [])
        XCTAssertEqual(decodedPlayer1.inPlay.map { $0.identifier }, [])
        
        let decodedHit1 = decoded.hits[0]
        XCTAssertEqual(decodedHit1.name, "hit1")
        XCTAssertEqual(decodedHit1.player, "p1")
        XCTAssertEqual(decodedHit1.abilities, ["ab1"])
        XCTAssertEqual(decodedHit1.cancelable, 1)
        XCTAssertEqual(decodedHit1.offender, "p2")
    }
    
    // MARK: - Event
    
    func test_EventEncoding() throws {
        // Given
        let events: [GEvent] = [
            .run(move: GMove("a1", actor: "p1")),
            .run(move: GMove("a1", actor: "p1", card: .hand("c1"))),
            .run(move: GMove("a1", actor: "p1", card: .inPlay("c1"))),
            .run(move: GMove("a1", actor: "p1", args: [.target: ["p2"]])),
            .activate(moves: [GMove("a1", actor: "p1"),
                              GMove("a2", actor: "p1")]),
            .play(player: "p1", card: "c1"),
            .equip(player: "p1", card: "c1"),
            .handicap(player: "p1", card: "c1", other: "p2"),
            .setTurn(player: "p1"),
            .setPhase(value: 2),
            .gainHealth(player: "p1"),
            .looseHealth(player: "p1", offender: "p2"),
            .eliminate(player: "p1", offender: "p2"),
            .drawDeck(player: "p1"),
            .drawHand(player: "p1", other: "p2", card: "c2"),
            .drawInPlay(player: "p1", other: "p2", card: "c2"),
            .drawStore(player: "p1", card: "c1"),
            .drawDiscard(player: "p1"),
            .discardHand(player: "p1", card: "c1"),
            .discardInPlay(player: "p1", card: "c1"),
            .passInPlay(player: "p1", card: "c1", other: "p2"),
            .deckToStore,
            .storeToDeck(card: "c1"),
            .flipDeck,
            .drawDeckFlipping(player: "p1"),
            .addHit(player: "p1", name: "h1", abilities: ["a1", "a2"], cancelable: 1, offender: "p2"),
            .removeHit(player: "p1"),
            .cancelHit(player: "p1"),
            .gameover(winner: .renegade),
            .emptyQueue
        ]
        
        try events.forEach { event in
            // When
            let encoded = sut.encode(event: event)
            let decoded = try sut.decode(event: encoded)
            
            // Assert
            XCTAssertEqual(decoded, event)
        }
    }
    
    // MARK: - User
    
    func test_UserInfoEncoding() throws {
        // Given
        let user = UserInfo(id: "1", name: "user1", photoUrl: "https://photo1.png")
        
        // When
        let encoded = sut.encode(user: user)
        let decoded = try sut.decode(user: encoded)
        
        // Assert
        XCTAssertEqual(decoded, user)
    }
    
    func test_UserStatusIdleEncoding() throws {
        // Given
        let status = UserStatus.idle
        
        // When
        let encoded = sut.encode(status: status)
        
        // Assert
        XCTAssertNil(encoded)
    }
    
    func test_UserStatusWaitingEncoding() throws {
        // Given
        let status = UserStatus.waiting
        
        // When
        // When
        let encoded = sut.encode(status: status)
        let decoded = try sut.decode(status: encoded!)
        
        // Assert
        XCTAssertEqual(decoded, status)
    }
    
    func test_UserStatusPlayingEncoding() throws {
        // Given
        let status = UserStatus.playing(gameId: "g1", playerId: "p1")
        
        // When
        // When
        let encoded = sut.encode(status: status)
        let decoded = try sut.decode(status: encoded!)
        
        // Assert
        XCTAssertEqual(decoded, status)
    }
}
