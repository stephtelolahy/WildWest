//
//  GameMove.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// A concrete action performed by a player or the game itself
struct GameMove: Equatable {
    let name: MoveName                  // move type
    var actorId: String?                // identifier of player performing move
    var cardId: String?                 // identifier of played/chosen card
    var cardName: CardName?             // name of played card
    var targetId: String?               // identifier of targeted player
    var targetCard: TargetCard?         // identifier of targeted card
    var discardIds: [String]?           // identifiers of discarded hand cards
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

extension MoveName {
    static let play = MoveName("play")              // phase2: play a hand card
    static let endTurn = MoveName("endTurn")        // phase3: end turn discarding excess cards
    static let discard = MoveName("discard")        // reaction move: discard card to cancel attacked
    static let pass = MoveName("pass")              // reaction move: do nothing while attacked
    static let choose = MoveName("choose")          // reaction move: choose one card from general store
}

struct TargetCard: Equatable {
    let ownerId: String
    let source: TargetCardSource
}

enum TargetCardSource: Equatable {
    case randomHand
    case inPlay(String)
}
