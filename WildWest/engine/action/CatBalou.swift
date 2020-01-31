//
//  CatBalou.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

enum CardSource: Equatable {
    case hand, inPlay
}

struct CatBalou: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let targetPlayerId: String
    let targetCardId: String
    let targetCardSource: CardSource
    
    func execute(state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        switch targetCardSource {
        case .hand:
            state.discardHand(playerId: targetPlayerId, cardId: targetCardId)
        case .inPlay:
            state.discardInPlay(playerId: targetPlayerId, cardId: targetCardId)
        }
    }
    
    var description: String {
        "\(actorId) play \(cardId) to discard \(targetPlayerId)'s \(targetCardId) from \(targetCardSource)"
    }
}

struct CatBalouRule: RuleProtocol {
    
    func match(state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let player = state.players[state.turn]
        let cards = player.handCards(named: .catBalou)
        guard !cards.isEmpty else {
            return []
        }
        
        var result: [CatBalou] = []
        let otherPlayers = state.players.filter { $0.identifier != player.identifier }
        for card in cards {
            for otherPlayer in otherPlayers {
                for handCard in otherPlayer.hand {
                    result.append(CatBalou(actorId: player.identifier,
                                           cardId: card.identifier,
                                           targetPlayerId: otherPlayer.identifier,
                                           targetCardId: handCard.identifier,
                                           targetCardSource: .hand))
                }
                for inPlayCard in otherPlayer.inPlay {
                    result.append(CatBalou(actorId: player.identifier,
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
