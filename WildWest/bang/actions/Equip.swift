//
//  Equip.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// Blue-bordered cards
/// are played face up in front of you (exception: Jail).
/// Blue cards in front of you are hence defined to be “in play”.
/// The effect of these cards lasts until they are discarded or
/// removed somehow (e.g. through the play of a CatBalou),
/// or a special event occurs (e.g. in the case of Dynamite).
/// There is no limit on the cards you can have in front of you
/// provided that they do not share the same name.
///
struct Equip: ActionProtocol {
    
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.equip(playerId: actorId, cardId: cardId)
    }
}

extension Equip: RuleProtocol {
    
    // swiftlint:disable line_length
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        let playerId = state.players[state.turn].identifier
        let items: [CardName] = [.volcanic, .schofield, .remington, .winchester, .revCarbine, .barrel, .mustang, .scope, .dynamite]
        let cards = state.matchingCards(playerId: playerId, names: items)
        // TODO: cards in front of you should not share the same name
        return cards.map { Equip(actorId: playerId, cardId: $0.identifier) }
    }
}
