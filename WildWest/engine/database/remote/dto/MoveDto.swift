//
//  MoveDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

struct MoveDto: Codable {
    let name: String?
    let actorId: String?
    let cardId: String?
    let targetId: String?
    let targetCard: TargetCardDto?
    var discardIds: [String]?
}

struct TargetCardDto: Codable {
    let ownerId: String?
    let source: TargetCardSourceDto?
}

struct TargetCardSourceDto: Codable {
    var randomHand: Bool?
    var inPlay: String?
}
