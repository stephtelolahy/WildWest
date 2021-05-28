//
//  MoveSelectorTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 15/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class MoveSelectorTests: XCTestCase {
    
    private var sut: MoveSelectorProtocol!
    
    override func setUp() {
        sut = MoveSelector()
    }
    
    // MARK: - Same ability No args
    
    func test_SelectSingleMoveNoArgs() throws {
        // Given
        let move1 = GMove("endTurn", actor: "p1")
        
        // When
        let root = sut.select([move1])
        
        // Assert
        XCTAssertEqual(root.name, "endTurn")
        XCTAssertEqual(root.value, .move(move1))
    }
    
    func test_SelectSinglePlayCardMove() throws {
        // Given
        let move1 = GMove("equip", actor: "p1", card: .hand("mustang-8-♥️"))
        
        // When
        let root = sut.select([move1])
        
        // Assert
        XCTAssertEqual(root.name, "mustang-8-♥️")
        XCTAssertEqual(root.value, .move(move1))
    }
    
    // MARK: - Same ability Single arg
    
    func test_SelectInnerMoveWithTarget() throws {
        // Given
        let move1 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p1"]])
        let move2 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p2"]])
        
        // When
        let root = sut.select([move1, move2])
        
        // Assert
        XCTAssertEqual(root.name, "startTurnDrawingPlayer")
        XCTAssertEqual(root.value, .options([MoveNode(name: "p1", value: .move(move1)),
                                             MoveNode(name: "p2", value: .move(move2))]))
    }
    
    func test_SelectPlayCardMoveWithTarget() throws {
        // Given
        let move1 = GMove("bang", actor: "pX", card: .hand("bang-10-♠️"), args: [.target: ["p1"]])
        let move2 = GMove("bang", actor: "pX", card: .hand("bang-10-♠️"), args: [.target: ["p2"]])
        
        // When
        let root = sut.select([move1, move2])
        
        // Assert
        XCTAssertEqual(root.name, "bang-10-♠️")
        XCTAssertEqual(root.value, .options([MoveNode(name: "p1", value: .move(move1)),
                                             MoveNode(name: "p2", value: .move(move2))]))
    }
    
    func test_SelectMoveWithRequiredStore() throws {
        // Given
        let move1 = GMove("drawStore", actor: "pX", args: [.requiredStore: ["c1", "c3"]])
        let move2 = GMove("drawStore", actor: "pX", args: [.requiredStore: ["c2", "c3"]])
        
        // When
        let root = sut.select([move1, move2])
        
        // Assert
        XCTAssertEqual(root.name, "drawStore")
        XCTAssertEqual(root.value, .options([MoveNode(name: "c1, c3", value: .move(move1)),
                                             MoveNode(name: "c2, c3", value: .move(move2))]))
    }
    
    func test_SelectMoveWithRequiredDeck() throws {
        // Given
        let move1 = GMove("drawDeckChoosing2", actor: "pX", args: [.requiredDeck: ["c1", "c3"]])
        let move2 = GMove("drawDeckChoosing2", actor: "pX", args: [.requiredDeck: ["c2", "c3"]])
        
        // When
        let root = sut.select([move1, move2])
        
        // Assert
        XCTAssertEqual(root.name, "drawDeckChoosing2")
        XCTAssertEqual(root.value, .options([MoveNode(name: "c1, c3", value: .move(move1)),
                                             MoveNode(name: "c2, c3", value: .move(move2))]))
    }
    
    func test_SelectMoveWithRequiredHand() throws {
        // Given
        let move1 = GMove("whisky", actor: "pX", args: [.requiredHand: ["remington-9-♠️"]])
        let move2 = GMove("whisky", actor: "pX", args: [.requiredHand: ["volcanic-10-♠️"]])
        
        // When
        let root = sut.select([move1, move2])
        
        // Assert
        XCTAssertEqual(root.name, "whisky")
        XCTAssertEqual(root.value, .options([MoveNode(name: "remington-9-♠️", value: .move(move1)),
                                             MoveNode(name: "volcanic-10-♠️", value: .move(move2))]))
    }
    
    // MARK: - Same ability Multiple args
    
    func test_SelectMoveWithTargetThenRequiredInPlay() throws {
        // Given
        let move11 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p1"], .requiredInPlay: ["c11"]])
        let move12 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p1"], .requiredInPlay: ["c12"]])
        let move21 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p2"], .requiredInPlay: ["c21"]])
        let move22 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p2"], .requiredInPlay: ["c22"]])
        
        // When
        let root = sut.select([move11, move12, move21, move22])
        
        // Assert
        XCTAssertEqual(root.name, "discardAnyInPlay")
        guard case let .options(nodes) = root.value else {
            XCTFail("Invalid value")
            return
        }
        XCTAssertEqual(nodes.count, 2)
        
        XCTAssertEqual(nodes[0].name, "p1")
        XCTAssertEqual(nodes[0].value, .options([MoveNode(name: "c11", value: .move(move11)),
                                                 MoveNode(name: "c12", value: .move(move12))]))
        
        XCTAssertEqual(nodes[1].name, "p2")
        XCTAssertEqual(nodes[1].value, .options([MoveNode(name: "c21", value: .move(move21)),
                                                 MoveNode(name: "c22", value: .move(move22))]))
    }
    
    func test_SelectMoveWithRequiredHandThenTarget() throws {
        // Given
        let move11 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c1"], .target: ["p1"]])
        let move12 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c1"], .target: ["p2"]])
        let move21 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c2"], .target: ["p1"]])
        let move22 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c2"], .target: ["p2"]])
        
        // When
        let root = sut.select([move11, move12, move21, move22])
        
        // Assert
        XCTAssertEqual(root.name, "springfield")
        guard case let .options(nodes) = root.value else {
            XCTFail("Invalid value")
            return
        }
        XCTAssertEqual(nodes.count, 2)
        
        XCTAssertEqual(nodes[0].name, "c1")
        XCTAssertEqual(nodes[0].value, .options([MoveNode(name: "p1", value: .move(move11)),
                                                 MoveNode(name: "p2", value: .move(move12))]))
        
        XCTAssertEqual(nodes[1].name, "c2")
        XCTAssertEqual(nodes[1].value, .options([MoveNode(name: "p1", value: .move(move21)),
                                                 MoveNode(name: "p2", value: .move(move22))]))
    }
    
    // MARK: - Different abilities
    
    func test_SelectMoveAmongDifferentAbilitiesNoArg() throws {
        // Given
        let move1 = GMove("startTurnDrawingDiscard", actor: "pX")
        let move2 = GMove("startTurnDrawingDeck", actor: "pX")
        
        // When
        let root = sut.select([move1, move2])
        
        // Assert
        XCTAssertEqual(root.value, .options([MoveNode(name: "startTurnDrawingDiscard", value: .move(move1)),
                                             MoveNode(name: "startTurnDrawingDeck", value: .move(move2))]))
    }
    
    func test_SelectMoveAmongDifferentAbilitiesWithCard() throws {
        // Given
        let move1 = GMove("looseHealth", actor: "pX")
        let move2 = GMove("missed", actor: "pX", card: .hand("missed-10-♣️"))
        let move3 = GMove("missed", actor: "pX", card: .hand("missed-7-♠️"))
        
        // When
        let root = sut.select([move1, move2, move3])
        
        // Assert
        XCTAssertEqual(root.value, .options([MoveNode(name: "looseHealth", value: .move(move1)),
                                             MoveNode(name: "missed-10-♣️", value: .move(move2)),
                                             MoveNode(name: "missed-7-♠️", value: .move(move3))]))
    }
    
    func test_SelectMoveAmongDifferentAbilitiesWithArgs() throws {
        // Given
        let move1 = GMove("startTurnDrawingDeck", actor: "pX")
        let move2 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p2"]])
        let move3 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p3"]])
        
        // When
        let root = sut.select([move1, move2, move3])
        
        // Assert
        XCTAssertEqual(root.value, .options([MoveNode(name: "startTurnDrawingDeck", value: .move(move1)),
                                             MoveNode(name: "startTurnDrawingPlayer p2", value: .move(move2)),
                                             MoveNode(name: "startTurnDrawingPlayer p3", value: .move(move3))]))
    }
}
