//
//  MoveDescriptor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol MoveDescriptor {
    func description(for move: GameMove) -> String?
}

extension MoveDescriptor {
    func description(for move: GameMove) -> String? {
        switch move {
        case let .startTurn(actorId):
            return "🔥 \(actorId) starts turn phase1"
            
        case let .beer(actorId, cardId):
            return "🍺 \(actorId) plays \(cardId)"
            
        }
    }
}
