//
//  DiscardableCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 11/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum CardSource: Equatable {
    case hand, inPlay
}

typealias DiscardableCard = (cardId: String, ownerId: String, source: CardSource)
