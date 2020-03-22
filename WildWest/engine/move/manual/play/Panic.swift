//
//  Panic.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class PanicMatcher: ValidMoveMatcherProtocol {
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .panic) else {
                return nil
        }
        
        let reachableDistance = 1
        let otherPlayers = state.players.filter {
            $0.identifier != actor.identifier
                && calculator.distance(from: actor.identifier, to: $0.identifier, in: state) <= reachableDistance
        }
        
        guard let targetCards = state.targetCards(from: otherPlayers) else {
            return nil
        }
        
        return cards.map { card in
            targetCards.map {
                GameMove(name: .play,
                         actorId: actor.identifier,
                         cardId: card.identifier,
                         cardName: card.name,
                         targetCard: $0)
            }
        }.flatMap { $0 }
    }
}

class PanicExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            case .panic = move.cardName,
            let cardId = move.cardId,
            let actorId = move.actorId,
            let targetCard = move.targetCard else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        switch targetCard.source {
        case .randomHand:
            if let player = state.players.first(where: { $0.identifier == targetCard.ownerId }),
                let card = player.hand.randomElement() {
                updates.append(.playerPullFromOtherHand(actorId, targetCard.ownerId, card.identifier))
            }
        case let .inPlay(targetCardId):
            updates.append(.playerPullFromOtherInPlay(actorId, targetCard.ownerId, targetCardId))
        }
        return updates
    }
}
