//
//  Challenge.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct Challenge: Equatable {
    let name: ChallengeName
    let targetIds: [String]
    let damage: Int
}

enum ChallengeName: String {
    case startTurn
    case bang
    case duel
    case gatling
    case indians
    case generalStore
    case dynamiteExploded
    case discardExcessCards
}
