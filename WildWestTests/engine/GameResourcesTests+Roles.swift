//
//  GameResourcesTests+Roles.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameResourcesTests_Roles: XCTestCase {

    private lazy var roles: [RoleCard] = {
        let jsonReader = JsonReader(bundle: Bundle(for: type(of: self)))
        let sut: GameResources = GameResources(jsonReader: jsonReader)
        return sut.allRoles()
    }()
    
    func test_AllRolesAreAvailable() {
        XCTAssertTrue(roles.contains { $0.role == .sheriff })
        XCTAssertTrue(roles.contains { $0.role == .outlaw })
        XCTAssertTrue(roles.contains { $0.role == .deputy })
        XCTAssertTrue(roles.contains { $0.role == .renegade })
    }
    
    func test_AllRolesHaveValidImage() {
        let bundle = Bundle(for: type(of: self))
        XCTAssertTrue(roles.allSatisfy { UIImage(named: $0.imageName, in: bundle, compatibleWith: nil) != nil })
    }

}
