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
    
    func execute(state: GameStateProtocol) {
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

extension Panic: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [Panic] {
        guard state.challenge == nil else {
            return []
        }
        
        let player = state.players[state.turn]
        let cards = player.handCards(named: .panic)
        guard !cards.isEmpty else {
            return []
        }
        
        var result: [Panic] = []
        let otherPlayers = state.players.filter {
            $0.identifier != player.identifier
            && state.distance(from: player.identifier, to: $0.identifier) <= 1
        }
        
        for card in cards {
            for otherPlayer in otherPlayers {
                for handCard in otherPlayer.hand {
                    result.append(Panic(actorId: player.identifier,
                                        cardId: card.identifier,
                                        targetPlayerId: otherPlayer.identifier,
                                        targetCardId: handCard.identifier,
                                        targetCardSource: .hand))
                }
                for inPlayCard in otherPlayer.inPlay {
                    result.append(Panic(actorId: player.identifier,
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
