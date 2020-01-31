//
//  ArrayExtensionTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 31/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class ArrayExtensionTests: XCTestCase {

    func test_Combination() {
        XCTAssertEqual(["a", "b", "c"].combine(by: 1), [["a"], ["b"], ["c"]])
        XCTAssertEqual(["a", "b", "c"].combine(by: 2), [["a", "b"], ["a", "c"], ["b", "c"]])
        XCTAssertEqual(["a", "b", "c"].combine(by: 3), [["a", "b", "c"]])
        XCTAssertEqual(["a", "b", "c"].combine(by: 4), [["a", "b", "c"]])
        XCTAssertEqual(["a", "b", "c", "d"].combine(by: 2), [["a", "b"], ["a", "c"], ["a", "d"], ["b", "c"], ["b", "d"], ["c", "d"]])
        XCTAssertEqual(["a", "b", "c", "d"].combine(by: 3), [["a", "b", "c"], ["a", "b", "d"], ["a", "c", "d"], ["b", "c", "d"]])
        XCTAssertEqual(["d", "c", "b", "a"].combine(by: 3), [["d", "c", "b"], ["d", "c", "a"], ["d", "b", "a"], ["c", "b", "a"]])
    }
}
