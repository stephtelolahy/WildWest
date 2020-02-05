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
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.setChallenge(.shoot([targetId]))
        state.setTurnShoots(state.turnShoots + 1)
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
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil else {
            return nil
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .bang)
        guard !cards.isEmpty else {
            return nil
        }
        
        let maxShoots = calculator.maximumNumberOfShoots(of: actor)
        guard maxShoots == 0 || state.turnShoots < maxShoots  else {
            return nil
        }
        
        let otherPlayers = state.players.filter { player -> Bool in
            guard player.identifier != actor.identifier else {
                return false
            }
            
            let distance = calculator.distance(from: actor.identifier, to: player.identifier, in: state)
            let reachableDistance = calculator.reachableDistance(of: actor)
            return distance <= reachableDistance
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            let options = otherPlayers.map { Shoot(actorId: actor.identifier,
                                                   cardId: card.identifier,
                                                   targetId: $0.identifier)
            }
            return GenericAction(name: card.name.rawValue,
                                 actorId: actor.identifier,
                                 cardId: card.identifier,
                                 options: options)
        }
    }
}
