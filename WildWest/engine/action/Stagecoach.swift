//
//  Stagecoach.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Stagecoach: PlayCardAtionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .playerPullFromDeck(actorId, 2)
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct StagecoachRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .stagecoach) else {
                return nil
        }
        
        return cards.map { Stagecoach(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
