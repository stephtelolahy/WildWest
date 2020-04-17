//
//  Challenge.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

// Challenge is a prior state waiting for reaction
struct Challenge: Equatable {
    let name: ChallengeName
    let targetIds: [String]
    let damage: Int
    let counterNeeded: Int
    let barrelsPlayed: Int
}

enum ChallengeName: String {
    case startTurn          // draw 2 cards to begin turn, but resolve dynamite and jail first
    case bang               // counter bang (damage=1) with missed or beer if last life point
    case duel               // counter duel (damage=1) with bang or beer if last life point
    case gatling            // counter gatling (damage=1) with missed or beer if last life point
    case indians            // counter indians (damage=1) with bang or beer if last life point
    case generalStore       // choose card from general store
    case dynamiteExploded   // avoid elimination after dynamite exploded (damage=1..3) with beer 
    case discardExcessCards // discard cards until hand cards = life points
}
