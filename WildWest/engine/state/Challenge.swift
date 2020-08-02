//
//  Challenge.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

// Challenge is a prior state waiting for reaction
struct Challenge: Equatable {
    let name: MoveName
    var targetIds: [String]?
    var damage: Int?
    var counterNeeded: Int?
    var barrelsPlayed: Int?
}
