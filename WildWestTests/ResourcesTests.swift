//
//  ResourcesTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class ResourcesTests: XCTestCase {
    
    private var sut: ResourcesLoaderProtocol!
    
    override func setUp() {
        sut = ResourcesLoader(jsonReader: JsonReader(bundle: Bundle.resourcesBundle))
    }

    func test_AllCardsHaveImage() {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        // When
        let cards = sut.loadCards()
        
        let brownCards = cards.filter { $0.type == .brown }
        let blueCards = cards.filter { $0.type == .blue }
        let figureCards = cards.filter { $0.type == .figure }
        
        // Assert
        (brownCards + blueCards + figureCards).forEach {
            XCTAssertNotNil(UIImage(named: $0.name, in: bundle, compatibleWith: nil), "Misssing asset for \($0.name)")
        }
    }

}
