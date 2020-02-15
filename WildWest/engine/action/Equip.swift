//
//  Equip.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Equip: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let player = state.players.first(where: { $0.identifier == actorId }),
            let card = player.hand.first(where: { $0.identifier == cardId }) else {
                return []
        }
        
        var updates: [GameUpdate] = []
        
        if card.isGun,
            let currentGun = player.inPlay.first(where: { $0.isGun }) {
            updates.append(.playerDiscardInPlay(actorId, currentGun.identifier))
        }
        
        updates.append(.playerPutInPlay(actorId, cardId))
        
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct EquipRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
                return nil
        }
        
        let equipableCardNames: [CardName] = [.volcanic,
                                              .schofield,
                                              .remington,
                                              .winchester,
                                              .revCarbine,
                                              .mustang,
                                              .scope,
                                              .barrel,
                                              .dynamite]
        let cards = actor.hand.filter {
            equipableCardNames.contains($0.name)
                && actor.inPlayCards(named: $0.name) == nil
        }
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { Equip(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
