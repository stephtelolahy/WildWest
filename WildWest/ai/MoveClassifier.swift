//
//  MoveClassifier.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol MoveClassifierProtocol {
    func classify(_ move: GameMove) -> MoveClassification
}

enum MoveClassification {
    case strongAttack(actorId: String, targetId: String)
    case weakAttack(actorId: String, targetId: String)
    case help(actorId: String, targetId: String)
    case none
}

class MoveClassifier: MoveClassifierProtocol {
    
    func classify(_ move: GameMove) -> MoveClassification {
        
        if move.name == .bang || move.name == .duel,
            let targetId = move.targetId {
            return .strongAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if case .jail = move.name,
            let targetId = move.targetId {
            return .weakAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if move.name == .panic || move.name == .catBalou,
            let targetCard = move.targetCard {
            if case let .inPlay(cardId) = targetCard.source,
                cardId.contains(CardName.jail.rawValue) {
                return .help(actorId: move.actorId, targetId: targetCard.ownerId)
            } else {
                return .weakAttack(actorId: move.actorId, targetId: targetCard.ownerId)
            }
        }
        
        return .none
    }
}
