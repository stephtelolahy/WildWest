//
//  GameLayoutBuilderTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameLayoutBuilderTests: XCTestCase {
    
    private let sut = GameLayoutBuilder()
    
    func test_LayoutFor4Players() {
        // Given
        // When
        let frames = sut.buildLayout(for: 4,
                                     size: CGSize(width: 13, height: 10),
                                     padding: 1)
        
        // Assert
        XCTAssertEqual(frames[0], CGRect(x: 5.5, y: 7, width: 2, height: 2))
        XCTAssertEqual(frames[1], CGRect(x: 1, y: 4, width: 2, height: 2))
        XCTAssertEqual(frames[2], CGRect(x: 5.5, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[3], CGRect(x: 10, y: 4, width: 2, height: 2))
    }
    
    func test_LayoutFor5Players() {
        // Given
        // When
        let frames = sut.buildLayout(for: 5,
                                     size: CGSize(width: 13, height: 10),
                                     padding: 1)
        
        // Assert
        XCTAssertEqual(frames[0], CGRect(x: 5.5, y: 7, width: 2, height: 2))
        XCTAssertEqual(frames[1], CGRect(x: 1, y: 4, width: 2, height: 2))
        XCTAssertEqual(frames[2], CGRect(x: 3, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[3], CGRect(x: 8, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[4], CGRect(x: 10, y: 4, width: 2, height: 2))
    }
    
    func test_LayoutFor6Players() {
        // Given
        // When
        let frames = sut.buildLayout(for: 6,
                                     size: CGSize(width: 13, height: 10),
                                     padding: 1)
        
        // Assert
        XCTAssertEqual(frames[0], CGRect(x: 5.5, y: 7, width: 2, height: 2))
        XCTAssertEqual(frames[1], CGRect(x: 1, y: 4, width: 2, height: 2))
        XCTAssertEqual(frames[2], CGRect(x: 1.75, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[3], CGRect(x: 5.5, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[4], CGRect(x: 9.25, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[5], CGRect(x: 10, y: 4, width: 2, height: 2))
    }
    
    func test_LayoutFor7Players() {
        // Given
        // When
        let frames = sut.buildLayout(for: 7,
                                     size: CGSize(width: 13, height: 10),
                                     padding: 1)
        
        // Assert
        XCTAssertEqual(frames[0], CGRect(x: 5.5, y: 7, width: 2, height: 2))
        XCTAssertEqual(frames[1], CGRect(x: 1, y: 4, width: 2, height: 2))
        XCTAssertEqual(frames[2], CGRect(x: 1, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[3], CGRect(x: 4, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[4], CGRect(x: 7, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[5], CGRect(x: 10, y: 1, width: 2, height: 2))
        XCTAssertEqual(frames[6], CGRect(x: 10, y: 4, width: 2, height: 2))
    }
}
