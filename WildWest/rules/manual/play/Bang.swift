//
//  Bang.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class BangMatcher: MoveMatcherProtocol {
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        let maxShoots = calculator.maximumNumberOfShoots(of: actor)
        guard maxShoots == 0 || state.bangsPlayed < maxShoots  else {
            return nil
        }
        
        let reachableDistance = calculator.reachableDistance(of: actor)
        let otherPlayers = state.players.filter {
            $0.identifier != actor.identifier
                && calculator.distance(from: actor.identifier, to: $0.identifier, in: state) <= reachableDistance
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            otherPlayers.map {
                GameMove(name: .play,
                         actorId: actor.identifier,
                         cardId: card.identifier,
                         cardName: card.name,
                         targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            case .bang = move.cardName,
            let actorId = move.actorId,
            let cardId = move.cardId,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(.shoot([targetId], .bang, actorId))]
    }
}
