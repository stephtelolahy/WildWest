//
//  Player.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/9/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Player {
    let role: Role
    let ability: Ability
    let health: Int
    let maxHealth: Int
    let hand: [Card]
    let inPlay: [Card]
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
