//
//  MoveSegmenterTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 15/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class MoveSegmenterTests: XCTestCase {

    private var sut: MoveSegmenterProtocol!
    
    override func setUp() {
        sut = MoveSegmenter()
    }
    
    func test_SegmentEndTurnMove() {
        // Given
        let moves = [GMove("endTurn", actor: "p1")]
        // When
        let segments = sut.segment(moves)
        
        // Assert
        XCTAssertEqual(segments["endTurn"], moves)
    }
    
    func test_SegmentPlayHandMoves() {
        // Given
        let moves = [GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]]),
                     GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p3"]]),
                     GMove("m2", actor: "p1", card: .hand("c2"))]
        // When
        let segments = sut.segment(moves)
        
        // Assert
        XCTAssertEqual(segments["c1"], [GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]]), 
                                        GMove("m1", actor: "p1", card: .hand("c1"), args: [.target: ["p3"]])])
        XCTAssertEqual(segments["c2"], [GMove("m2", actor: "p1", card: .hand("c2"))])
    }
    
    func test_SegmentOtherMoves() {
        // Given
        let moves = [GMove("m1", actor: "p1"),
                     GMove("m2", actor: "p1", args: [.target: ["p2"]]),
                     GMove("m3", actor: "p1", args: [.requiredHand: ["c2", "c3"]]),
                     GMove("m4", actor: "p1", args: [.requiredStore: ["c1"]]),
                     GMove("m5", actor: "p1", args: [.target: ["p2"], .requiredInPlay: ["c5"]])]
        // When
        let segments = sut.segment(moves)
        
        // Assert
        XCTAssertEqual(segments["*"], moves)
    }
    
}
