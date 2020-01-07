//
//  CardTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CardTests: XCTestCase {

    func test_CardIdentifier_Is_TheConcatenationOf_Name_Value_Suit() {
        XCTAssertEqual(Card(name: .barrel, value: "9", suit: .clubs).identifier, "barrel-9-clubs")
        XCTAssertEqual(Card(name: .dynamite, value: "K", suit: .spades).identifier, "dynamite-K-spades")
    }
}
