//
//  Panic.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

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
        "\(actorId) play \(cardId) to discard \(targetPlayerId)'s \(targetCardId) from \(targetCardSource)"
    }
}

struct PanicRule: RuleProtocol {
    
    let actionName: String = "Panic"
    
    private let calculator: RangeCalculatorProtocol
    
    init(calculator: RangeCalculatorProtocol) {
        self.calculator = calculator
    }
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .panic)
        guard !cards.isEmpty else {
            return []
        }
        
        var result: [Panic] = []
        let otherPlayers = state.players.filter {
            $0.identifier != actor.identifier
            && calculator.distance(from: actor.identifier, to: $0.identifier, in: state) <= 1
        }
        
        for card in cards {
            for otherPlayer in otherPlayers {
                for handCard in otherPlayer.hand {
                    result.append(Panic(actorId: actor.identifier,
                                        cardId: card.identifier,
                                        targetPlayerId: otherPlayer.identifier,
                                        targetCardId: handCard.identifier,
                                        targetCardSource: .hand))
                }
                for inPlayCard in otherPlayer.inPlay {
                    result.append(Panic(actorId: actor.identifier,
                                        cardId: card.identifier,
                                        targetPlayerId: otherPlayer.identifier,
                                        targetCardId: inPlayCard.identifier,
                                        targetCardSource: .inPlay))
                }
            }
        }
        
        return result
    }
}
