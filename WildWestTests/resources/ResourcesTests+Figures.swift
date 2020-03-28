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
        let sut = GameConfiguration(jsonReader: jsonReader)
        return sut.allFigures
    }()
    
    func test_Load16PFigures() {
        XCTAssertEqual(figures.count, 16)
    }
    
    func test_AllFiguresAreAvailable() {
        XCTAssertTrue(figures.contains { $0.ability == .bartCassidy && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .blackJack && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .calamityJanet && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .elGringo && $0.bullets == 3 })
        XCTAssertTrue(figures.contains { $0.ability == .jesseJones && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .joudonais && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .kitCarlson && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .luckyDuke && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .paulRegret && $0.bullets == 3 })
        XCTAssertTrue(figures.contains { $0.ability == .pedroRamirez && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .roseDoolan && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .sidKetchum && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .slabTheKiller && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .suzyLafayette && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .vultureSam && $0.bullets == 4 })
        XCTAssertTrue(figures.contains { $0.ability == .willyTheKid && $0.bullets == 4 })
    }
    
    func test_AllFiguresHaveValidImage() {
        let bundle = Bundle(for: type(of: self))
        XCTAssertTrue(figures.allSatisfy { UIImage(named: $0.imageName, in: bundle, compatibleWith: nil) != nil })
    }
    
}
