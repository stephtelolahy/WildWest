//
//  MoveClassifier.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class MoveClassifier: MoveClassifierProtocol {
    
    func classify(_ move: GameMove) -> MoveClassification {
        guard case .play = move.name,
            let cardId = move.cardId else {
                return .none
        }
        
        if case .play = move.name,
            (cardId.contains("bang") || cardId.contains("duel")),
            let targetId = move.targetId {
            return .strongAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if case .bangWithMissed = move.name,
            let targetId = move.targetId {
            return .strongAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if case .play = move.name,
            cardId.contains("jail"),
            let targetId = move.targetId {
            return .weakAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if case .play = move.name,
            (cardId.contains("panic") || cardId.contains("catBalou")),
            let targetCard = move.targetCard {
            if case let .inPlay(cardId) = targetCard.source,
                cardId.contains("jail") {
                return .help(actorId: move.actorId, targetId: targetCard.ownerId)
            } else {
                return .weakAttack(actorId: move.actorId, targetId: targetCard.ownerId)
            }
        }
        
        return .none
    }
}
