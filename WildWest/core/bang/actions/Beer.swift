//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// Beer
/// This card lets you regain one life point – take a bullet from the pile.
/// You cannot gain more life points than your starting amount! The Beer cannot be used to help other players.
/// The Beer can be played in two ways:
/// - as usual, during your turn;
/// - out of turn, but only if you have just
/// received a hit that is lethal (i.e. a hit that takes away your last life point),
/// and not if you are simply hit.
/// Beer has no effect if there are only 2 players left in the game;
/// in other words, if you play a Beer you do not gain any life point.
///
struct Beer: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(state: MutableGameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
    }
}

extension Beer: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .beer)
        return cards.map { Beer(actorId: player.identifier, cardId: $0.identifier) }
    }
}
