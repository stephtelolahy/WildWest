//
//  CardTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class CardTests: XCTestCase {
    
    func test_CardIdentifier_IsAppending_Name_Value_Suit() {
        // Given
        let sut = Card(name: .barrel, value: "9", suit: .clubs, imageName: "image_name")
        
        // When
        // Assert
        XCTAssertEqual(sut.identifier, "barrel-9-clubs")
    }
}
