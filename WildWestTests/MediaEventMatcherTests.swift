//
//  MediaEventMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class MediaEventMatcherTests: XCTestCase {
    
    private var sut: MediaEventMatcherProtocol!
    
    override func setUp() {
        let jsonReader = JsonReader(bundle: Bundle(for: MediaEventMatcher.self))
        let mediaArray: [EventMedia] = jsonReader.load("media")
        sut = MediaEventMatcher(mediaArray: mediaArray)
    }
    
    // MARK: - Play Events
    
    func test_PlayBang() {
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("bang", actor: "p1"))), "🔫")
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("discardBangOnDuel", actor: "p1"))), "🔫")
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("discardBangOnIndians", actor: "p1"))), "🔫")
    }
    
    func test_PlayDuel() {
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("duel", actor: "p1"))), "🔫")
    }
    
    func test_PlayMissed() {
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("missed", actor: "p1"))), "😝")
    }
    
    func test_PlayDrawCard() {
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("stagecoach", actor: "p1"))), "🎁")
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("wellsFargo", actor: "p1"))), "🎁")
    }
    
    func test_PlayMassiveShoot() {
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("gatling", actor: "p1"))), "💢")
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("indians", actor: "p1"))), "💢")
    }
    
    func test_PlayCommon() {
        XCTAssertEqual(sut.emoji(on: .run(move: GMove("any", actor: "p1"))), "👍")
    }
    
    // MARK: - Update Events
    
    func test_DrawCard() {
        XCTAssertEqual(sut.emoji(on: .drawDeck(player: "p1")), "💰")
        XCTAssertEqual(sut.emoji(on: .drawDiscard(player: "p1")), "💰")
        XCTAssertEqual(sut.emoji(on: .drawStore(player: "p1", card: "c1")), "💰")
    }
    
    func test_RevealCard() {
        XCTAssertEqual(sut.emoji(on: .flipDeck), "🌟")
        XCTAssertEqual(sut.emoji(on: .drawDeckFlipping(player: "p1")), "🌟")
    }
    
    func test_DiscardCard() {
        XCTAssertEqual(sut.emoji(on: .discardHand(player: "p1", card: "c1")), "❌")
        XCTAssertEqual(sut.emoji(on: .discardInPlay(player: "p1", card: "c1")), "❌")
    }
    
    func test_DrawFromPlayer() {
        XCTAssertEqual(sut.emoji(on: .drawHand(player: "p1", other: "p2", card: "c1")), "‼️")
        XCTAssertEqual(sut.emoji(on: .drawInPlay(player: "p1", other: "p2", card: "c1")), "‼️")
    }
    
    func test_PassToPlayer() {
        XCTAssertEqual(sut.emoji(on: .passInPlay(player: "p1", card: "c1", other: "p2")), "💣")
    }
    
    func test_Equip() {
        XCTAssertEqual(sut.emoji(on: .equip(player: "p1", card: "c1")), "😎")
    }
    
    func test_Handicap() {
        XCTAssertEqual(sut.emoji(on: .handicap(player: "p1", card: "c1", other: "p2")), "⚠️")
    }
    
    func test_Store() {
        XCTAssertEqual(sut.emoji(on: .deckToStore), "🎁")
        XCTAssertEqual(sut.emoji(on: .storeToDeck(card: "c1")), "🎁")
    }
    
    func test_GainHealth() {
        XCTAssertEqual(sut.emoji(on: .gainHealth(player: "p1")), "🍺")
    }
    
    func test_LooseHealth() {
        XCTAssertEqual(sut.emoji(on: .looseHealth(player: "p1", offender: "p2")), "❤️")
    }
    
    func test_Eliminate() {
        XCTAssertEqual(sut.emoji(on: .eliminate(player: "p1", offender: "p2")), "☠️")
    }
    
    func test_GameOver() {
        XCTAssertEqual(sut.emoji(on: .gameover(winner: .renegade)), "🎉")
    }
    
    func test_StartTurn() {
        XCTAssertEqual(sut.emoji(on: .setTurn(player: "p1")), "🔥")
    }
    
    func test_SetPhase() {
        XCTAssertEqual(sut.emoji(on: .setPhase(value: 1)), "✔️")
    }
    
    func test_DynamiteExploded() {
        XCTAssertEqual(sut.emoji(on: .addHit(player: "p1", name: "dynamite", abilities: [], cancelable: 0, offender: "p1")), "😰")
        XCTAssertNil(sut.emoji(on: .addHit(player: "p1", name: "any", abilities: [], cancelable: 0, offender: "p1")))
    }
    
    // MARK: - Engine events
    
    func test_Activate() {
        XCTAssertEqual(sut.emoji(on: .activate(moves: [])), "🎮")
    }
    
    func test_EmptyQueue() {
        XCTAssertEqual(sut.emoji(on: .emptyQueue), "💤")
    }
    
}
