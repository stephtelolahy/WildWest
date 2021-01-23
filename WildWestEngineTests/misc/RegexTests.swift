//
//  RegexTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 09/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable function_body_length

import XCTest
import WildWestEngine

class RegexTests: XCTestCase {

    // https://regex101.com/
    private let escapeFromJail = "♥️"
    private let passDynamite = "(♥️)|(♦️)|(♣️)|([10|J|Q|K|A]♠️)"

    func test_EscapeFromJail() {

        XCTAssertTrue(MockCardProtocol().value(is: "2").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "3").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "4").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "5").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "6").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "7").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "8").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "9").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "10").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "J").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "Q").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "K").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().value(is: "A").suit(is: "♥️").matches(regex: escapeFromJail))

        XCTAssertFalse(MockCardProtocol().value(is: "2").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "3").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "4").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "5").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "6").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "7").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "8").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "9").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "10").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "J").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "Q").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "K").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "A").suit(is: "♦️").matches(regex: escapeFromJail))

        XCTAssertFalse(MockCardProtocol().value(is: "2").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "3").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "4").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "5").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "6").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "7").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "8").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "9").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "10").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "J").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "Q").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "K").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "A").suit(is: "♠️").matches(regex: escapeFromJail))

        XCTAssertFalse(MockCardProtocol().value(is: "2").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "3").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "4").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "5").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "6").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "7").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "8").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "9").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "10").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "J").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "Q").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "K").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().value(is: "A").suit(is: "♣️").matches(regex: escapeFromJail))
    }

    func test_PassDynamite() {
        XCTAssertTrue(MockCardProtocol().value(is: "2").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "3").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "4").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "5").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "6").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "7").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "8").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "9").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "10").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "J").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "Q").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "K").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "A").suit(is: "♥️").matches(regex: passDynamite))

        XCTAssertTrue(MockCardProtocol().value(is: "2").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "3").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "4").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "5").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "6").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "7").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "8").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "9").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "10").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "J").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "Q").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "K").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "A").suit(is: "♦️").matches(regex: passDynamite))

        XCTAssertFalse(MockCardProtocol().value(is: "2").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "3").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "4").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "5").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "6").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "7").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "8").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().value(is: "9").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "10").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "J").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "Q").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "K").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "A").suit(is: "♠️").matches(regex: passDynamite))

        XCTAssertTrue(MockCardProtocol().value(is: "2").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "3").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "4").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "5").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "6").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "7").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "8").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "9").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "10").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "J").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "Q").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "K").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().value(is: "A").suit(is: "♣️").matches(regex: passDynamite))
    }

}
