//
//  Panic.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Panic: PlayCardAtionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let target: TargetCard
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        switch target.source {
        case .randomHand:
            if let player = state.players.first(where: { $0.identifier == target.ownerId }),
                let card = player.hand.randomElement() {
                updates.append(.playerPullFromOtherHand(actorId, target.ownerId, card.identifier))
            }
        case let .inPlay(targetCardId):
            updates.append(.playerPullFromOtherInPlay(actorId, target.ownerId, targetCardId))
        }
        return updates
    }
    
    var description: String {
        switch target.source {
        case .randomHand:
            return "\(actorId) plays \(cardId) to take random hand card from \(target.ownerId)"
        case let .inPlay(targetCardId):
            return "\(actorId) plays \(cardId) to take \(targetCardId) from \(target.ownerId)"
        }
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
        
        guard let targetCards = state.targetCards(from: actor, and: otherPlayers) else {
            return nil
        }
        
        return cards.map { card in
            targetCards.map { Panic(actorId: actor.identifier, cardId: card.identifier, target: $0) }
        }.flatMap { $0 }
    }
}
