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
    let targetPlayerId: String
    let targetCardId: String
    let targetCardSource: CardSource
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        switch targetCardSource {
        case .hand:
            state.discardHand(playerId: targetPlayerId, cardId: targetCardId)
        case .inPlay:
            state.discardInPlay(playerId: targetPlayerId, cardId: targetCardId)
        }
    }
    
    var description: String {
        "\(actorId) plays \(cardId) to discard \(targetCardId) from \(targetPlayerId)'s \(targetCardSource)"
    }
}

struct CatBalouRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .catBalou) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
        let discardableCards = state.discardableCards(from: actor, and: otherPlayers)
        guard !discardableCards.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            let options = discardableCards.map { CatBalou(actorId: actor.identifier,
                                                          cardId: card.identifier,
                                                          targetPlayerId: $0.ownerId,
                                                          targetCardId: $0.cardId,
                                                          targetCardSource: $0.source)
            }
            
            return GenericAction(name: card.name.rawValue,
                                 actorId: actor.identifier,
                                 cardId: card.identifier,
                                 options: options)
        }
    }
}
