//
//  GameMove.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// A concrete action performed by a player
struct GameMove: Equatable {
    let name: MoveName
    let actorId: String
    var cardId: String?
    var targetId: String?
    var targetCard: TargetCard?
    var discardIds: [String]?
}

struct MoveName: RawRepresentable, Equatable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    var rawValue: String
}

struct TargetCard: Equatable {
    let ownerId: String
    let source: TargetCardSource
}

enum TargetCardSource: Equatable {
    case randomHand
    case inPlay(String)
}
