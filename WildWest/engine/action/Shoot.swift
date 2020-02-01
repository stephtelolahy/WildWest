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
        state.setChallenge(.bang(actorId: actorId, targetId: targetId))
        state.setTurnShoots(state.turnShoots + 1)
    }
    
    var description: String {
        "\(actorId) play \(cardId) against \(targetId)"
    }
}

struct ShootRule: RuleProtocol {
    
    let actionName: String = "Shoot"
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let player = state.players[state.turn]
        let cards = player.handCards(named: .shoot)
        guard !cards.isEmpty else {
            return []
        }
        
        let maxShoots = calculator.maximumNumberOfShoots(of: player)
        guard maxShoots == 0 || state.turnShoots < maxShoots  else {
            return []
        }
        
        let otherPlayers = state.players.filter { aPlayer -> Bool in
            guard aPlayer.identifier != player.identifier else {
                return false
            }
            
            let distance = calculator.distance(from: player.identifier, to: aPlayer.identifier, in: state)
            let reachableDistance = calculator.reachableDistance(of: player)
            return distance <= reachableDistance
        }
        
        var result: [Shoot] = []
        for card in cards {
            for otherPlayer in otherPlayers {
                result.append(Shoot(actorId: player.identifier,
                                    cardId: card.identifier,
                                    targetId: otherPlayer.identifier))
            }
        }
        
        return result
    }
}
