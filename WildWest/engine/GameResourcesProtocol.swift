//
//  GameResourcesProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameResourcesProtocol {
    func allCards() -> [CardProtocol]
    func allFigures() -> [Figure]
}
