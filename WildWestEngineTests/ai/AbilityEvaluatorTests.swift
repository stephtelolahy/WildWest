//
//  AbilityEvaluatorTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 27/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class AbilityEvaluatorTests: XCTestCase {

    private var sut: AbilityEvaluatorProtocol!
    
    override func setUp() {
        sut = AbilityEvaluator()
    }
    
    func test_DiscourageEndingTurn() {
        XCTAssertEqual(sut.evaluate(GMove("endTurn", actor: "p1")), -1)
    }
    
    func test_DiscourageLoosingHealth() {
        XCTAssertEqual(sut.evaluate(GMove("looseHealth", actor: "p1")), -1)
    }
    
    func test_StrongAttack() {
        XCTAssertEqual(sut.evaluate(GMove("bang", actor: "p1")), 3)
        XCTAssertEqual(sut.evaluate(GMove("duel", actor: "p1")), 3)
    }
    
    func test_WeakAttack() {
        XCTAssertEqual(sut.evaluate(GMove("handicap", actor: "p1")), 1)
        XCTAssertEqual(sut.evaluate(GMove("discardOtherHand", actor: "p1")), 1)
        XCTAssertEqual(sut.evaluate(GMove("discardOtherInPlay", actor: "p1")), 1)
        XCTAssertEqual(sut.evaluate(GMove("drawOtherHandAt1", actor: "p1")), 1)
        XCTAssertEqual(sut.evaluate(GMove("drawOtherInPlayAt1", actor: "p1")), 1)
    }
    
    func test_Help() {
        XCTAssertEqual(sut.evaluate(GMove("discardOtherInPlay", actor: "p1", args: [.requiredInPlay: ["jail-9-♠️"]])), -1)
        XCTAssertEqual(sut.evaluate(GMove("drawOtherInPlayAt1", actor: "p1", args: [.requiredInPlay: ["jail-10-♠️"]])), -1)
    }
}
