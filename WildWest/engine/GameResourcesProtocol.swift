//
//  GameResourcesProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameResourcesProtocol {
    func allCards() -> [Card]
    func allFigures() -> [Figure]
    func allRoles() -> [RoleCard]
}
