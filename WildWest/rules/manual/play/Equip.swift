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
        
        let cards = actor.hand.filter {
            ($0.name.isEquipment || $0.name.isGun)
                && actor.inPlayCards(named: $0.name) == nil
        }
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map {
            GameMove(name: .play, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId),
            let card = actor.handCard(cardId),
            (card.name.isEquipment || card.name.isGun) else {
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
