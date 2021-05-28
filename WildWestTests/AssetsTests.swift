//
//  AssetsTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class AssetsTests: XCTestCase {
    
    private var sut: ResourcesLoaderProtocol!
    
    override func setUp() {
        sut = ResourcesLoader(jsonReader: JsonReader(bundle: Bundle.resourcesBundle))
    }

    func test_AllPlayCardsHaveImage() {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        // When
        let cards = sut.loadCards()
        let brownCards = cards.filter { $0.type == .brown }
        let blueCards = cards.filter { $0.type == .blue }
        
        // Assert
        (brownCards + blueCards).forEach {
            XCTAssertNotNil(UIImage(named: $0.name, in: bundle, compatibleWith: nil), "Misssing asset for \($0.name)")
        }
    }
    
    func test_AllFiguresHaveFullImage() {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        // When
        let cards = sut.loadCards()
        let figureCards = cards.filter { $0.type == .figure }
        
        figureCards.forEach {
            XCTAssertNotNil(UIImage(named: $0.name, in: bundle, compatibleWith: nil), "Misssing asset for \($0.name)")
            XCTAssertNotNil(UIImage(named: "01_\($0.name.lowercased())", in: bundle, compatibleWith: nil), "Misssing full image for \($0.name)")
        }
    }
    
    func test_AllRolesHaveFullImage() {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        // When
        let roles = Role.allCases
        
        roles.forEach {
            XCTAssertNotNil(UIImage(named: $0.rawValue, in: bundle, compatibleWith: nil), "Misssing asset for \($0)")
            XCTAssertNotNil(UIImage(named: "01_\($0.rawValue.lowercased())", in: bundle, compatibleWith: nil), "Misssing fulla image for \($0)")
        }
    }

}
