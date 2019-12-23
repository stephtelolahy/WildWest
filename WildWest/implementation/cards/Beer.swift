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
struct Beer: ActionProtocol {
    
    let playerId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: playerId, cardId: cardId)
        state.gainLifePoint(playerId: playerId)
    }
}

extension Beer: RuleProtocol {
    
    static func match(playerId: String, state: GameStateProtocol) -> [ActionProtocol] {
        guard let player = state.players.first(where: { $0.identifier == playerId }) else {
            return []
        }
        // TODO: Beer has no effect if there are only 2 players left in the game
        let beerCards = player.hand.cards.filter { $0.name == .beer }
        return beerCards.map { Beer(playerId: playerId, cardId: $0.identifier) }
    }
}
