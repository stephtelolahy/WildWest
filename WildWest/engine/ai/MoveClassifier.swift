//
//  MoveClassifier.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class MoveClassifier: MoveClassifierProtocol {
    func classify(_ move: GameMove) -> MoveClassification {
        if case .play = move.name,
            [CardName.bang, CardName.duel].contains(move.cardName),
            let targetId = move.targetId {
            return .strongAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if case .play = move.name,
            case .jail = move.cardName,
            let targetId = move.targetId {
            return .weakAttack(actorId: move.actorId, targetId: targetId)
        }
        
        if case .play = move.name,
            [CardName.panic, CardName.catBalou].contains(move.cardName),
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
