//
//  RegexTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 09/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine

class RegexTests: XCTestCase {

    // https://regex101.com/
    private let escapeFromJail = "♥️"
    private let passDynamite = "(♥️)|(♦️)|(♣️)|([10|J|Q|K|A]♠️)"
    private let isDiamonds = "♦️"
    private let isJail = "jail"
    private let isAny = ""

    func test_EscapeFromJail() {

        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "2").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "3").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "4").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "5").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "6").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "7").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "8").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "9").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "10").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "J").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "K").suit(is: "♥️").matches(regex: escapeFromJail))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "A").suit(is: "♥️").matches(regex: escapeFromJail))

        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "2").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "3").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "4").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "5").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "6").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "7").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "8").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "9").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "10").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "J").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "K").suit(is: "♦️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "A").suit(is: "♦️").matches(regex: escapeFromJail))

        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "2").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "3").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "4").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "5").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "6").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "7").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "8").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "9").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "10").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "J").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "K").suit(is: "♠️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "A").suit(is: "♠️").matches(regex: escapeFromJail))

        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "2").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "3").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "4").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "5").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "6").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "7").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "8").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "9").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "10").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "J").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "K").suit(is: "♣️").matches(regex: escapeFromJail))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "A").suit(is: "♣️").matches(regex: escapeFromJail))
    }

    func test_PassDynamite() {
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "2").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "3").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "4").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "5").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "6").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "7").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "8").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "9").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "10").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "J").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "K").suit(is: "♥️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "A").suit(is: "♥️").matches(regex: passDynamite))

        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "2").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "3").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "4").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "5").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "6").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "7").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "8").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "9").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "10").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "J").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "K").suit(is: "♦️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "A").suit(is: "♦️").matches(regex: passDynamite))

        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "2").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "3").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "4").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "5").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "6").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "7").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "8").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertFalse(MockCardProtocol().withDefault().value(is: "9").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "10").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "J").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "K").suit(is: "♠️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "A").suit(is: "♠️").matches(regex: passDynamite))

        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "2").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "3").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "4").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "5").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "6").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "7").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "8").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "9").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "10").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "J").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "Q").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "K").suit(is: "♣️").matches(regex: passDynamite))
        XCTAssertTrue(MockCardProtocol().withDefault().value(is: "A").suit(is: "♣️").matches(regex: passDynamite))
    }
    
    func test_IsDiamonds() {
        XCTAssertTrue(MockCardProtocol().withDefault().suit(is: "♦️").matches(regex: isDiamonds))
    }
    
    func test_IsJail() {
        XCTAssertTrue(MockCardProtocol().withDefault().named("jail").matches(regex: isJail))
    }
    
    func test_IsAny() {
        XCTAssertTrue(MockCardProtocol().withDefault().named("gatling").matches(regex: isAny))
    }

}
