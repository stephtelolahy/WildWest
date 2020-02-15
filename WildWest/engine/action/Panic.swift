//
//  Panic.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct DiscardableCard: Equatable {
    let cardId: String
    let ownerId: String
    let source: CardSource
}

enum CardSource: Equatable {
    case hand, inPlay
}

struct Panic: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let target: DiscardableCard
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        switch target.source {
        case .hand:
            updates.append(.playerPullFromOtherHand(actorId, target.ownerId, target.cardId))
        case .inPlay:
            updates.append(.playerPullFromOtherInPlay(actorId, target.ownerId, target.cardId))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId) to take \(target.cardId) from \(target.ownerId)'s \(target.source)"
    }
}

struct PanicRule: RuleProtocol {
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
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
        
        guard let discardableCards = state.discardableCards(from: actor, and: otherPlayers) else {
            return nil
        }
        
        return cards.map { card in
            discardableCards.map { Panic(actorId: actor.identifier, cardId: card.identifier, target: $0) }
        }.flatMap { $0 }
    }
}
