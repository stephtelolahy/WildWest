//
//  Panic.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

enum CardSource: Equatable {
    case hand, inPlay
}

struct Panic: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let targetPlayerId: String
    let targetCardId: String
    let targetCardSource: CardSource
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        switch targetCardSource {
        case .hand:
            state.pullHand(playerId: actorId, otherId: targetPlayerId, cardId: targetCardId)
        case .inPlay:
            state.pullInPlay(playerId: actorId, otherId: targetPlayerId, cardId: targetCardId)
        }
    }
    
    var description: String {
        "\(actorId) plays \(cardId) to discard \(targetCardId) from \(targetPlayerId)'s \(targetCardSource)"
    }
}

struct PanicRule: RuleProtocol {
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
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
        
        let discardableCards = state.discardableCards(from: actor, and: otherPlayers)
        guard !discardableCards.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            let options = discardableCards.map { Panic(actorId: actor.identifier,
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
