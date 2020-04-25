//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StartTurnMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            !actor.inPlay.contains(where: { $0.name == .jail }),
            !actor.inPlay.contains(where: { $0.name == .dynamite }) else {
                return nil
        }
        
        return GameMove(name: .startTurn, actorId: actor.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .startTurn = move.name,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = [.setChallenge(nil),
                                     .playerSetBangsPlayed(move.actorId, 0),
                                     .playerPullFromDeck(move.actorId),
                                     .playerPullFromDeck(move.actorId)]
        
        if actor.abilities[.drawsAnotherCardIfSecondDrawIsRedSuit] == true {
            let secondCard = state.deck[1]
            updates.append(.playerRevealHandCard(move.actorId, secondCard.identifier))
            if secondCard.suit.isRed {
                updates.append(.playerPullFromDeck(move.actorId))
            }
        }
        
        return updates
    }
}

extension MoveName {
    static let startTurn = MoveName("startTurn")
}
