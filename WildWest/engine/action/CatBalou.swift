//
//  CatBalou.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct TargetCard: Equatable {
    let ownerId: String
    let source: TargetCardSource
}

enum TargetCardSource: Equatable {
    case randomHand
    case inPlay(String)
}

struct CatBalou: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let target: TargetCard
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        switch target.source {
        case .randomHand:
            if let player = state.players.first(where: { $0.identifier == target.ownerId }),
                let card = player.hand.randomElement() {
                updates.append(.playerDiscardHand(target.ownerId, card.identifier))
            }
        case let .inPlay(targetCardId):
            updates.append(.playerDiscardInPlay(target.ownerId, targetCardId))
        }
        return updates
    }
    
    var description: String {
        switch target.source {
        case .randomHand:
            return "\(actorId) plays \(cardId) to discard random hand card from \(target.ownerId)"
        case let .inPlay(targetCardId):
            return "\(actorId) plays \(cardId) to discard \(targetCardId) from \(target.ownerId)"
        }
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
        guard let targetCards = state.targetCards(from: actor, and: otherPlayers) else {
            return nil
        }
        return cards.map { card in
            targetCards.map { CatBalou(actorId: actor.identifier, cardId: card.identifier, target: $0) }
        }.flatMap { $0 }
    }
}
