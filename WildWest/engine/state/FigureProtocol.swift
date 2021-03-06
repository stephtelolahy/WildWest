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

enum AbilityName: String, Codable, CaseIterable {
    case hasBarrelAllTimes
    case hasMustangAllTimes
    case hasScopeAllTimes
    case hasNoLimitOnBangsPerTurn
    case drawsCardOnLoseHealth
    case drawsCardFromPlayerDamagedHim
    case drawsCardWhenHandIsEmpty
    case canPlayBangAsMissAndViceVersa
    case othersNeed2MissesToCounterHisBang
    case takesAllCardsFromEliminatedPlayers
    case flips2CardsOnADrawAndChoose1
    case canDiscard2CardsFor1Life
    case onStartTurnDrawsAnotherCardIfRedSuit
    case onStartTurnDraws3CardsAndKeep2
    case onStartTurnCanDrawFirstCardFromPlayer
    case onStartTurnCanDrawFirstCardFromDiscard
}
