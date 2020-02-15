//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StartTurn: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String = ""
    
    var description: String {
        "\(actorId) starts turn"
    }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [.setTurn(actorId),
                                     .setChallenge(nil),
                                     .setBangsPlayed(0),
                                     .playerPullFromDeck(actorId),
                                     .playerPullFromDeck(actorId)]
        return updates
    }
}

struct StartTurnRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard case let .startTurn(actorId) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == actorId }),
            actor.inPlay.filter({ $0.name == .jail || $0.name == .dynamite }).isEmpty else {
                return nil
        }
        
        return [StartTurn(actorId: actor.identifier)]
    }
}
