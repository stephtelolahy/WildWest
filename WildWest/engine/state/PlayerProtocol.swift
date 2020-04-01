//
//  PlayerProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol PlayerProtocol {
    var identifier: String { get }
    var role: Role? { get }
    var figure: FigureProtocol { get }
    var maxHealth: Int { get }
    var health: Int { get }
    var hand: [CardProtocol] { get }
    var inPlay: [CardProtocol] { get }
}

enum Role: String {
    case sheriff,
    outlaw,
    renegade,
    deputy
}
