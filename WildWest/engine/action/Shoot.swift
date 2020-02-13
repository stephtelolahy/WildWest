//
//  Shoot.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Shoot: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let targetId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .setChallenge(.shoot([targetId])),
            .setBangsPlayed(state.bangsPlayed + 1)
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId) against \(targetId)"
    }
}

struct ShootRule: RuleProtocol {
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
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
            otherPlayers.map { Shoot(actorId: actor.identifier, cardId: card.identifier, targetId: $0.identifier) }
        }.flatMap { $0 }
    }
}
