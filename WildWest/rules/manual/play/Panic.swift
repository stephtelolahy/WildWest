//
//  Panic.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class PanicMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.handCards(named: .panic) else {
                return nil
        }
        
        let panicDistance = 1
        let otherPlayers = state.players.filter {
            $0.identifier != actor.identifier
                && state.distance(from: actor.identifier, to: $0.identifier) <= panicDistance
        }
        
        guard let targetCards = otherPlayers.targetableCards() else {
            return nil
        }
        
        return cards.map { card in
            targetCards.map {
                GameMove(name: .play, actorId: actor.identifier, cardId: card.identifier, targetCard: $0)
            }
        }.flatMap { $0 }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId),
            let card = actor.handCard(cardId),
            case .panic = card.name,
            let targetCard = move.targetCard else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(move.actorId, cardId))
        switch targetCard.source {
        case .randomHand:
            if let player = state.player(targetCard.ownerId),
                let card = player.hand.randomElement() {
                updates.append(.playerPullFromOtherHand(move.actorId, targetCard.ownerId, card.identifier))
            }
        case let .inPlay(targetCardId):
            updates.append(.playerPullFromOtherInPlay(move.actorId, targetCard.ownerId, targetCardId))
        }
        return updates
    }
}
