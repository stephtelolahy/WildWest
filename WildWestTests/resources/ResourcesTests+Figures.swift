//
//  ResourcesTests+Figures.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class ResourcesTests_Figures: XCTestCase {
    
    private lazy var figures: [FigureProtocol] = {
        let jsonReader = JsonReader(bundle: Bundle(for: type(of: self)))
        let sut = GameResources(jsonReader: jsonReader)
        return sut.allFigures
    }()
    
    func test_AllFiguresAreAvailable() {
        XCTAssertEqual(figures.count, 16)
        XCTAssertTrue(figures.contains { $0.name == .bartCassidy && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .blackJack && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .calamityJanet && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .elGringo && $0.bullets == 3 })
        XCTAssertTrue(figures.contains { $0.name == .jesseJones && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .joudonais && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .kitCarlson && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .luckyDuke && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .paulRegret && $0.bullets == 3 })
        XCTAssertTrue(figures.contains { $0.name == .pedroRamirez && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .roseDoolan && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .sidKetchum && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .slabTheKiller && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .suzyLafayette && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .vultureSam && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.name == .willyTheKid && $0.bullets == 4 })
    }
    
    func test_AllFiguresHaveValidImage() {
        let bundle = Bundle(for: type(of: self))
        XCTAssertTrue(figures.allSatisfy { UIImage(named: $0.imageName, in: bundle, compatibleWith: nil) != nil })
    }
    
}
