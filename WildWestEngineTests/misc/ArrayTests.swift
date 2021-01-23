//
//  ArrayTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine

class ArrayTests: XCTestCase {

    func test_Combine() {
        XCTAssertEqual(["a", "b", "c"].combine(by: 1), [["a"], ["b"], ["c"]])
        XCTAssertEqual(["a", "b", "c"].combine(by: 2), [["a", "b"], ["a", "c"], ["b", "c"]])
        XCTAssertEqual(["a", "b", "c"].combine(by: 3), [["a", "b", "c"]])
        XCTAssertEqual(["a", "b", "c"].combine(by: 4), [])
        XCTAssertEqual(["a", "b", "c", "d"].combine(by: 2), [["a", "b"], ["a", "c"], ["a", "d"], ["b", "c"], ["b", "d"], ["c", "d"]])
        XCTAssertEqual(["a", "b", "c", "d"].combine(by: 3), [["a", "b", "c"], ["a", "b", "d"], ["a", "c", "d"], ["b", "c", "d"]])
    }

    func test_StartingWith() {
        XCTAssertEqual(["a", "b", "c"].starting(with: "a"), ["a", "b", "c"])
        XCTAssertEqual(["a", "b", "c"].starting(with: "b"), ["b", "c", "a"])
        XCTAssertEqual(["a", "b", "c"].starting(with: "c"), ["c", "a", "b"])
        XCTAssertEqual(["a", "b", "c"].starting(with: "x"), ["a", "b", "c"])
    }

}
