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
    var ability: Ability { get }
    var maxHealth: Int { get }
    var health: Int { get }
    var hand: [CardProtocol] { get }
    var inPlay: [CardProtocol] { get }
    var imageName: String { get }
}

enum Role: String, Codable {
    case sheriff,
    outlaw,
    renegade,
    deputy
}

enum Ability: String, Codable {
    case bartCassidy,
    blackJack,
    calamityJanet,
    elGringo,
    jesseJones,
    joudonais,
    kitCarlson,
    luckyDuke,
    paulRegret,
    pedroRamirez,
    roseDoolan,
    sidKetchum,
    slabTheKiller,
    suzyLafayette,
    vultureSam,
    willyTheKid
}
