//
//  MediaEventMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import CardGameEngine

class MediaEventMatcherTests: XCTestCase {

    private var sut: MediaEventMatcherProtocol!
    
    override func setUp() {
        let jsonReader = JsonReader(bundle: Bundle(for: MediaEventMatcher.self))
        let mediaArray: [EventMedia] = jsonReader.load("media")
        sut = MediaEventMatcher(mediaArray: mediaArray)
    }
    
    func test_MediaBang() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.emoji(on: .play(move: GMove("bang", actor: "p1"))), "🔫")
    }
}
