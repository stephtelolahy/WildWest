//
//  FigureProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol FigureProtocol {
    var name: FigureName { get }
    var bullets: Int { get }
    var imageName: String { get }
    var description: String { get }
    var abilities: [AbilityName: Bool] { get }
}

enum FigureName: String, Codable {
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

enum AbilityName: String, Codable {
    case hasBarrelAllTimes
    case hasMustangAllTimes
    case hasScopeAllTimes
    case hasNoLimitOnBangsPerTurn
    case drawsCardOnLoseHealth
    case drawsCardFromPlayerDamagedHim
    case drawsCardWhenHandIsEmpty
    case canPlayBangAsMissAndViceVersa
}
