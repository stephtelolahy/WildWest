//
//  Jail.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// Play this card in front of any player regardless of the distance: you put him in jail!
/// If you are in jail, you must “draw!” before the beginning of your turn:
/// - if you draw a Heart card, you escape from jail: discard the Jail, and continue your turn as normal;
/// - otherwise discard the Jail and skip your turn.
/// If you are in Jail you remain a possible target for BANG! cards
/// and can still play response cards (e.g. Missed! and Beer) out of your turn, if necessary.
/// Jail cannot be played on the Sheriff.
///
struct Jail: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: MutableGameStateProtocol) {
    }
}

extension Jail: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        return []
    }
}
