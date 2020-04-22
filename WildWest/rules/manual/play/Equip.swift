//
//  Equip.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class EquipMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn) else {
                return nil
        }
        
        guard let cards = actor.hand.filterOrNil({ card in
            (card.name.isEquipment || card.name.isGun) && !actor.inPlay.contains(where: { $0.name == card.name })
        }) else {
            return nil
        }
        
        return cards.map {
            GameMove(name: .equip, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .equip = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId),
            let card = actor.handCard(cardId) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        if card.name.isGun,
            let currentGun = actor.inPlay.first(where: { $0.name.isGun }) {
            updates.append(.playerDiscardInPlay(move.actorId, currentGun.identifier))
        }
        updates.append(.playerPutInPlay(move.actorId, cardId))
        return updates
    }
}

extension MoveName {
    static let equip = MoveName("equip")
}
