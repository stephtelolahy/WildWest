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
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
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
            GameMove(name: .play,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let cardName = move.cardName,
            (cardName.isEquipment || cardName.isGun),
            let actorId = move.actorId,
            let cardId = move.cardId,
            let actor = state.players.first(where: { $0.identifier == actorId }) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        if cardName.isGun,
            let currentGun = actor.inPlay.first(where: { $0.name.isGun }) {
            updates.append(.playerDiscardInPlay(actorId, currentGun.identifier))
        }
        updates.append(.playerPutInPlay(actorId, cardId))
        return updates
    }
}
