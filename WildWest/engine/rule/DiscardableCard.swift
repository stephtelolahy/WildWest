//
//  DiscardableCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 03/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum CardSource: Equatable {
    case hand, inPlay
}

struct DiscardableCard {
    let identifier: String
    let ownerId: String
    let source: CardSource
}
