//
//  Player.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/9/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol PlayerProtocol {
    var identifier: String { get }
    var role: Role { get }
    var ability: Ability { get }
    var maxHealth: Int { get }
    var health: Int { get set }
    var hand: [Card] { get set }
    var inPlay: [Card] { get set }
}

enum Role {
    case sheriff,
    outlaw,
    renegade,
    deputy
}

enum Ability {
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
