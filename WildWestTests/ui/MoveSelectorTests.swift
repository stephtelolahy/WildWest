//
//  MoveSelectorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 11/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import CardGameEngine

class MoveSelectorTests: XCTestCase {
    
    private var sut: MoveSelectorProtocol!
    
    override func setUp() {
        sut = MoveSelector()
    }
    
    // MARK: - Empty
    
    func test_ReturnsNil_IfEmptyMoves() {
        // Given
        // When
        let selection = sut.select(active: [])
        
        // Assert
        XCTAssertNil(selection)
    }
    
    // MARK: - Same ability
    
    func test_OptionsAreEmptyString_IfPlayingHandCard() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", card: .hand("c1"))]
        
        // When
        let selection = try XCTUnwrap(sut.select(active: moves))
        
        // Assert
        XCTAssertEqual(selection.title, "c1")
        XCTAssertEqual(selection.options, [""])
    }
    
    func test_OptionsAreEmptyString_IfPlayingInnerAbility() throws {
        // Given
        let moves = [GMove("m1", actor: "p1")]
        
        // When
        let selection = try XCTUnwrap(sut.select(active: moves))
        
        // Assert
        XCTAssertEqual(selection.title, "m1")
        XCTAssertEqual(selection.options, [""])
    }
    
    func test_OptionsAreTarget_IfPlayingHandCard() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]]),
                     GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p3"]]),
                     GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p4"]])]
        // When
        let selection = try XCTUnwrap(sut.select(active: moves)) 
        
        // Assert
        XCTAssertEqual(selection.title, "c1")
        XCTAssertEqual(selection.options, ["p2", "p3", "p4"])
    }
    
    func test_OptionsAreTarget_IfPlayingInnerAbility() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", args: [.target: ["p2"]]),
                     GMove("m1", actor: "p1", args: [.target: ["p3"]]),
                     GMove("m1", actor: "p1", args: [.target: ["p4"]])]
        // When
        let selection = try XCTUnwrap(sut.select(active: moves)) 
        
        // Assert
        XCTAssertEqual(selection.title, "m1")
        XCTAssertEqual(selection.options, ["p2", "p3", "p4"])
    }
    
    func test_OptionsAreRequiredInPlay_IfPlayingHandCard() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p2"], .requiredInPlay: ["c2"]]),
                     GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p3"], .requiredInPlay: ["c3"]]),
                     GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p4"], .requiredInPlay: ["c4"]])]
        // When
        let selection = try XCTUnwrap(sut.select(active: moves)) 
        
        // Assert
        XCTAssertEqual(selection.title, "c1")
        XCTAssertEqual(selection.options, ["p2, c2", "p3, c3", "p4, c4"])
    }
    
    func test_OptionsRequiredInPlay_IfPlayingInnerAbility() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", args: [.target: ["p2"], .requiredInPlay: ["c2"]]),
                     GMove("m1", actor: "p1", args: [.target: ["p3"], .requiredInPlay: ["c3"]]),
                     GMove("m1", actor: "p1", args: [.target: ["p4"], .requiredInPlay: ["c4"]])]
        // When
        let selection = try XCTUnwrap(sut.select(active: moves)) 
        
        // Assert
        XCTAssertEqual(selection.title, "m1")
        XCTAssertEqual(selection.options, ["p2, c2", "p3, c3", "p4, c4"])
    }
    
    func test_OptionsAreRequiredStore() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", args: [.requiredStore: ["c2"]]),
                     GMove("m1", actor: "p1", args: [.requiredStore: ["c3"]]),
                     GMove("m1", actor: "p1", args: [.requiredStore: ["c4"]])]
        // When
        let selection = try XCTUnwrap(sut.select(active: moves)) 
        
        // Assert
        XCTAssertEqual(selection.title, "m1")
        XCTAssertEqual(selection.options, ["c2", "c3", "c4"])
    }
    
    func test_OptionsAreRequiredHand() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", args: [.requiredHand: ["c2"]]),
                     GMove("m1", actor: "p1", args: [.requiredHand: ["c3"]]),
                     GMove("m1", actor: "p1", args: [.requiredHand: ["c4"]])]
        // When
        let selection = try XCTUnwrap(sut.select(active: moves)) 
        
        // Assert
        XCTAssertEqual(selection.title, "m1")
        XCTAssertEqual(selection.options, ["c2", "c3", "c4"])
    }
    
    func test_OptionsAreEmptyString_IfPlayingEquip() throws {
        // Given
        let moves = [GMove("equip", actor: "p1", args: [.requiredHand: ["c1"]])]
        
        // When
        let selection = try XCTUnwrap(sut.select(active: moves))
        
        // Assert
        XCTAssertEqual(selection.title, "c1")
        XCTAssertEqual(selection.options, [""])
    }
    
    func test_OptionsAreTarget_IfPlayingHandicap() throws {
        // Given
        let moves = [GMove("handicap", actor: "p1", args: [.requiredHand: ["c1"], .target: ["p2"]]),
                     GMove("handicap", actor: "p1", args: [.requiredHand: ["c1"], .target: ["p3"]]),
                     GMove("handicap", actor: "p1", args: [.requiredHand: ["c1"], .target: ["p4"]])]
        
        // When
        let selection = try XCTUnwrap(sut.select(active: moves))
        
        // Assert
        XCTAssertEqual(selection.title, "c1")
        XCTAssertEqual(selection.options, ["p2", "p3", "p4"])
    }
    
    // MARK: - Different abilities
    
    func test_OptionsAreMoveNameAndArgs_IfPlayingDifferentAbilities() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", args: [.target: ["p2"]]),
                     GMove("m2", actor: "p1", args: [.requiredHand: ["c1"]]),
                     GMove("m3", actor: "p1")]
        
        // When
        let selection = try XCTUnwrap(sut.select(active: moves))
        
        // Assert
        XCTAssertEqual(selection.title, "Select move")
        XCTAssertEqual(selection.options, ["m1 p2", "m2 c1", "m3"])
    }
    
    // MARK: - Reaction
    
    func test_ReturnsNil_IfReactingToHitWithEmptyMoves() {
        // Given
        // When
        let selection = sut.select(reactionTo: "h1", moves: [])
        
        // Assert
        XCTAssertNil(selection)
    }
    
    func test_OptionsAreMoveArgsOrName_IfReactingToHit() throws {
        // Given
        let moves = [GMove("m1", actor: "p1", card: .hand("c1")),
                     GMove("m2", actor: "p1", args: [.requiredHand: ["c2"]]),
                     GMove("m3", actor: "p1")]
        
        // When
        let selection = try XCTUnwrap(sut.select(reactionTo: "h1", moves: moves))
        
        // Assert
        XCTAssertEqual(selection.title, "h1")
        XCTAssertEqual(selection.options, ["c1", "c2", "m3"])
    }
}
