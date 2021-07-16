//
//  MoveSelectorTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 15/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable type_body_length

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
        let root = sut.select([move1], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "endTurn", value: move1)
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectSinglePlayCardMove() throws {
        // Given
        let move1 = GMove("equip", actor: "p1", card: .hand("mustang-8-♥️"))
        
        // When
        let root = sut.select([move1], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "mustang-8-♥️", value: move1)
        XCTAssertEqual(root, expected)
    }
    
    // MARK: - Same ability Single arg
    
    func test_SelectInnerMoveWithTarget() throws {
        // Given
        let move1 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p1"]])
        let move2 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p2"]])
        
        // When
        let root = sut.select([move1, move2], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "startTurnDrawingPlayer",
                            children: [Node(title: "p1", value: move1),
                                       Node(title: "p2", value: move2)])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectPlayCardMoveWithTarget() throws {
        // Given
        let move1 = GMove("bang", actor: "pX", card: .hand("bang-10-♠️"), args: [.target: ["p1"]])
        let move2 = GMove("bang", actor: "pX", card: .hand("bang-10-♠️"), args: [.target: ["p2"]])
        
        // When
        let root = sut.select([move1, move2], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "bang-10-♠️",
                            children: [Node(title: "p1", value: move1),
                                       Node(title: "p2", value: move2)])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveWithRequiredStore() throws {
        // Given
        let move1 = GMove("drawStore", actor: "pX", args: [.requiredStore: ["c1", "c3"]])
        let move2 = GMove("drawStore", actor: "pX", args: [.requiredStore: ["c2", "c3"]])
        
        // When
        let root = sut.select([move1, move2], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "drawStore",
                            children: [Node(title: "c1, c3", value: move1),
                                       Node(title: "c2, c3", value: move2)])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveWithRequiredDeck() throws {
        // Given
        let move1 = GMove("drawDeckChoosing2", actor: "pX", args: [.requiredDeck: ["c1", "c3"]])
        let move2 = GMove("drawDeckChoosing2", actor: "pX", args: [.requiredDeck: ["c2", "c3"]])
        
        // When
        let root = sut.select([move1, move2], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "drawDeckChoosing2",
                            children: [Node(title: "c1, c3", value: move1),
                                       Node(title: "c2, c3", value: move2)])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveWithRequiredHand() throws {
        // Given
        let move1 = GMove("whisky", actor: "pX", args: [.requiredHand: ["remington-9-♠️"]])
        let move2 = GMove("whisky", actor: "pX", args: [.requiredHand: ["volcanic-10-♠️"]])
        
        // When
        let root = sut.select([move1, move2], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "whisky",
                            children: [Node(title: "remington-9-♠️", value: move1),
                                       Node(title: "volcanic-10-♠️", value: move2)])
        XCTAssertEqual(root, expected)
    }
    
    // MARK: - Same ability Multiple args
    
    func test_SelectMoveWithTargetThenRequiredInPlay() throws {
        // Given
        let move11 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p1"], .requiredInPlay: ["c11"]])
        let move12 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p1"], .requiredInPlay: ["c12"]])
        let move21 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p2"], .requiredInPlay: ["c21"]])
        let move22 = GMove("discardAnyInPlay", actor: "pX", args: [.target: ["p2"], .requiredInPlay: ["c22"]])
        
        // When
        let root = sut.select([move11, move12, move21, move22], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "discardAnyInPlay",
                            children: [
                                Node(title: "p1",
                                     children: [
                                        Node(title: "c11", value: move11),
                                        Node(title: "c12", value: move12)
                                     ]),
                                Node(title: "p2",
                                     children: [
                                        Node(title: "c21", value: move21),
                                        Node(title: "c22", value: move22)
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveWithRequiredHandThenTarget() throws {
        // Given
        let move11 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c1"], .target: ["p1"]])
        let move12 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c1"], .target: ["p2"]])
        let move21 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c2"], .target: ["p1"]])
        let move22 = GMove("springfield", actor: "pX", args: [.requiredHand: ["c2"], .target: ["p2"]])
        
        // When
        let root = sut.select([move11, move12, move21, move22], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "springfield",
                            children: [
                                Node(title: "c1",
                                     children: [
                                        Node(title: "p1", value: move11),
                                        Node(title: "p2", value: move12)
                                     ]),
                                Node(title: "c2",
                                     children: [
                                        Node(title: "p1", value: move21),
                                        Node(title: "p2", value: move22)
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveWithRequiredHandThenTargetThenInPlayCard() throws {
        // Given
        let move11 = GMove("drawOtherInPlayRequire1Card", actor: "pX", args: [.requiredHand: ["c1"], .target: ["p1"], .requiredInPlay: ["c3"]])
        let move12 = GMove("drawOtherInPlayRequire1Card", actor: "pX", args: [.requiredHand: ["c1"], .target: ["p1"], .requiredInPlay: ["c4"]])
        let move21 = GMove("drawOtherInPlayRequire1Card", actor: "pX", args: [.requiredHand: ["c2"], .target: ["p1"], .requiredInPlay: ["c3"]])
        let move22 = GMove("drawOtherInPlayRequire1Card", actor: "pX", args: [.requiredHand: ["c2"], .target: ["p1"], .requiredInPlay: ["c4"]])
        
        // When
        let root = sut.select([move11, move12, move21, move22], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "drawOtherInPlayRequire1Card",
                            children: [
                                Node(title: "c1",
                                     children: [
                                        Node(title: "p1", children: [
                                            Node(title: "c3", value: move11),
                                            Node(title: "c4", value: move12)
                                        ])
                                     ]),
                                Node(title: "c2",
                                     children: [
                                        Node(title: "p1", children: [
                                            Node(title: "c3", value: move21),
                                            Node(title: "c4", value: move22)
                                        ])
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
    
    // MARK: - Different abilities
    
    func test_SelectMoveAmongDifferentAbilitiesNoArg() throws {
        // Given
        let move1 = GMove("startTurnDrawingDiscard", actor: "pX")
        let move2 = GMove("startTurnDrawingDeck", actor: "pX")
        
        // When
        let root = sut.select([move1, move2], suggestedTitle: "Play")
        
        // Assert
        let expected = Node(title: "Play",
                            children: [Node(title: "startTurnDrawingDiscard", value: move1),
                                       Node(title: "startTurnDrawingDeck", value: move2)])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveAmongDifferentAbilitiesNoArgs() throws {
        // Given
        let move1 = GMove("looseHealth", actor: "pX")
        let move2 = GMove("missed", actor: "pX", card: .hand("missed-10-♣️"))
        let move3 = GMove("missed", actor: "pX", card: .hand("missed-7-♠️"))
        
        // When
        let root = sut.select([move1, move2, move3], suggestedTitle: "bang")
        
        // Assert
        let expected = Node(title: "bang",
                            children: [Node(title: "looseHealth", value: move1),
                                       Node(title: "missed-10-♣️", value: move2),
                                       Node(title: "missed-7-♠️", value: move3)])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveAmongDifferentAbilitiesWithTarget() throws {
        // Given
        let move1 = GMove("startTurnDrawingDeck", actor: "pX")
        let move2 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p2"]])
        let move3 = GMove("startTurnDrawingPlayer", actor: "pX", args: [.target: ["p3"]])
        
        // When
        let root = sut.select([move1, move2, move3], suggestedTitle: "startTurn")
        
        // Assert
        let expected = Node(title: "startTurn",
                            children: [
                                Node(title: "startTurnDrawingDeck", value: move1),
                                Node(title: "startTurnDrawingPlayer",
                                     children: [
                                        Node(title: "p2", value: move2),
                                        Node(title: "p3", value: move3)
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveAmongSameCardButDifferentAbilities() throws {
        // Given
        let move11 = GMove("drawOtherHandAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p1"]])
        let move12 = GMove("drawOtherHandAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p2"]])
        let move21 = GMove("drawOtherInPlayAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p1"], .requiredInPlay: ["c1"]])
        let move22 = GMove("drawOtherInPlayAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p2"], .requiredInPlay: ["c2"]])
        
        // When
        let root = sut.select([move11, move12, move21, move22], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "panic-10-♠️",
                            children: [
                                Node(title: "drawOtherHandAt1",
                                     children: [
                                        Node(title: "p1", value: move11),
                                        Node(title: "p2", value: move12)
                                     ]),
                                Node(title: "drawOtherInPlayAt1",
                                     children: [
                                        Node(title: "p1", children: [
                                            Node(title: "c1", value: move21)
                                        ]),
                                        Node(title: "p2", children: [
                                            Node(title: "c2", value: move22)
                                        ])
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveAmongSameCardButDifferentAbilities2() throws {
        // Given
        let move11 = GMove("drawOtherHandAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p1"]])
        let move12 = GMove("drawOtherHandAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p2"]])
        let move21 = GMove("drawOtherInPlayAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p1"], .requiredInPlay: ["c1"]])
        
        // When
        let root = sut.select([move11, move12, move21], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "panic-10-♠️",
                            children: [
                                Node(title: "drawOtherHandAt1",
                                     children: [
                                        Node(title: "p1", value: move11),
                                        Node(title: "p2", value: move12)
                                     ]),
                                Node(title: "drawOtherInPlayAt1",
                                     children: [
                                        Node(title: "p1", children: [
                                            Node(title: "c1", value: move21)
                                        ])
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
    
    func test_SelectMoveAmongSameCardButDifferentAbilities3() throws {
        // Given
        let move11 = GMove("drawOtherHandAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p1"]])
        let move21 = GMove("drawOtherInPlayAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p1"], .requiredInPlay: ["c1"]])
        let move22 = GMove("drawOtherInPlayAt1", actor: "pX", card: .hand("panic-10-♠️"), args: [.target: ["p2"], .requiredInPlay: ["c2"]])
        
        // When
        let root = sut.select([move11, move21, move22], suggestedTitle: nil)
        
        // Assert
        let expected = Node(title: "panic-10-♠️",
                            children: [
                                Node(title: "drawOtherHandAt1",
                                     children: [
                                        Node(title: "p1", value: move11)
                                     ]),
                                Node(title: "drawOtherInPlayAt1",
                                     children: [
                                        Node(title: "p1", children: [
                                            Node(title: "c1", value: move21)
                                        ]),
                                        Node(title: "p2", children: [
                                            Node(title: "c2", value: move22)
                                        ])
                                     ])
                            ])
        XCTAssertEqual(root, expected)
    }
}
