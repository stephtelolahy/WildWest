//
//  DiscardableCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 11/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DiscardableCard: Equatable {
    let cardId: String
    let ownerId: String
    let source: CardSource
}

enum CardSource: Equatable {
    case hand, inPlay
}
