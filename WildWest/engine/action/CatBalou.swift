//
//  CatBalou.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct CatBalou: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let target: DiscardableCard
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        switch target.source {
        case .hand:
            updates.append(.playerDiscardHand(target.ownerId, target.cardId))
        case .inPlay:
            updates.append(.playerDiscardInPlay(target.ownerId, target.cardId))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId) to discard \(target.cardId) from \(target.ownerId)'s \(target.source)"
    }
}

struct CatBalouRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .catBalou) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
        guard let discardableCards = state.discardableCards(from: actor, and: otherPlayers) else {
            return nil
        }
        return cards.map { card in
            discardableCards.map { CatBalou(actorId: actor.identifier, cardId: card.identifier, target: $0) }
        }.flatMap { $0 }
    }
}
