//
//  AnimationEventMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 21/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length

import XCTest
import WildWestEngine
import Cuckoo

class AnimationEventMatcherTests: XCTestCase {
    
    private var sut: AnimationEventMatcherProtocol!
    private var mockUserPreferences: MockUserPreferencesProtocol!
    
    override func setUp() {
        mockUserPreferences = MockUserPreferencesProtocol()
        stub(mockUserPreferences) { mock in
            when(mock.updateDelay.get).thenReturn(1.0)
        }
        sut = AnimationEventMatcher(preferences: mockUserPreferences)
    }
    
    func test_MatchAnimation() {
        // Given
        // When
        // Assert
        
        // No animation
        XCTAssertNil(sut.animation(on: .activate(moves: [])))
        XCTAssertNil(sut.animation(on: .run(move: GMove("a1", actor: "p1"))))
        XCTAssertNil(sut.animation(on: .removeHit(player: "p1")))
        XCTAssertNil(sut.animation(on: .cancelHit(player: "p1")))
        XCTAssertNil(sut.animation(on: .gameover(winner: .renegade)))
        XCTAssertNil(sut.animation(on: .emptyQueue))
        
        // Dummy
        XCTAssertEqual(sut.animation(on: .setTurn(player: "p1")),
                       EventAnimation(type: .dummy, duration: 1.0))
        XCTAssertEqual(sut.animation(on: .setPhase(value: 2)),
                       EventAnimation(type: .dummy, duration: 1.0))
        XCTAssertEqual(sut.animation(on: .gainHealth(player: "p1")),
                       EventAnimation(type: .dummy, duration: 1.0))
        XCTAssertEqual(sut.animation(on: .looseHealth(player: "p1", offender: "p2")),
                       EventAnimation(type: .dummy, duration: 1.0))
        XCTAssertEqual(sut.animation(on: .eliminate(player: "p1", offender: "p2")),
                       EventAnimation(type: .dummy, duration: 1.0))
        XCTAssertEqual(sut.animation(on: .addHit( hits: [GHit(player: "p2", name: "h1", abilities: ["a1", "a2"], offender: "p1", cancelable: 1)])),
                       EventAnimation(type: .dummy, duration: 1.0))
        
        // Move card
        XCTAssertEqual(sut.animation(on: .play(player: "p1", card: "c1")),
                       EventAnimation(type: .move(card: "c1", source: .hand("p1"), target: .discard), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .equip(player: "p1", card: "c1")),
                       EventAnimation(type: .move(card: "c1", source: .hand("p1"), target: .inPlay("p1")), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .handicap(player: "p1", card: "c1", other: "p2")),
                       EventAnimation(type: .move(card: "c1", source: .hand("p1"), target: .inPlay("p2")), duration: 1.0))
        
        XCTAssertEqual(sut.animation(on: .drawDeck(player: "p1")),
                       EventAnimation(type: .move(card: nil, source: .deck, target: .hand("p1")), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .drawDeckChoosing(player: "p1", card: "c1")),
                       EventAnimation(type: .move(card: nil, source: .deck, target: .hand("p1")), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .drawHand(player: "p1", other: "p2", card: "c2")),
                       EventAnimation(type: .move(card: nil, source: .hand("p2"), target: .hand("p1")), duration: 1.0))
        
        XCTAssertEqual(sut.animation(on: .drawInPlay(player: "p1", other: "p2", card: "c2")),
                       EventAnimation(type: .move(card: "c2", source: .inPlay("p2"), target: .hand("p1")), duration: 1.0))
        
        XCTAssertEqual(sut.animation(on: .drawStore(player: "p1", card: "c1")),
                       EventAnimation(type: .move(card: "c1", source: .store, target: .hand("p1")), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .drawDiscard(player: "p1")),
                       EventAnimation(type: .move(card: StateCard.discard, source: .discard, target: .hand("p1")), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .discardHand(player: "p1", card: "c1")),
                       EventAnimation(type: .move(card: "c1", source: .hand("p1"), target: .discard), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .discardInPlay(player: "p1", card: "c1")),
                       EventAnimation(type: .move(card: "c1", source: .inPlay("p1"), target: .discard), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .passInPlay(player: "p1", card: "c1", other: "p2")),
                       EventAnimation(type: .move(card: "c1", source: .inPlay("p1"), target: .inPlay("p2")), duration: 1.0))
        
        // Reveal card
        XCTAssertEqual(sut.animation(on: .deckToStore),
                       EventAnimation(type: .reveal(card: StateCard.deck, source: .deck, target: .store), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .flipDeck),
                       EventAnimation(type: .reveal(card: StateCard.deck, source: .deck, target: .discard), duration: 1.0))
        XCTAssertEqual(sut.animation(on: .drawDeckFlipping(player: "p1")),
                       EventAnimation(type: .reveal(card: StateCard.deck, source: .deck, target: .hand("p1")), duration: 1.0))
    }
}
