//
//  GState+Copy.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 15/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public extension GState {
    static func copy(_ state: StateProtocol) -> GState {
        GState(players: state.players.mapValues { GPlayer.copy($0) },
               initialOrder: state.initialOrder,
               playOrder: state.playOrder,
               turn: state.turn,
               phase: state.phase,
               deck: state.deck,
               discard: state.discard,
               store: state.store,
               hits: state.hits.map { GHit.copy($0) },
               played: state.played,
               history: state.history,
               winner: state.winner)
    }
}

private extension GPlayer {
    static func copy(_ player: PlayerProtocol) -> GPlayer {
        GPlayer(identifier: player.identifier,
                name: player.name,
                desc: player.desc,
                attributes: player.attributes,
                abilities: player.abilities,
                role: player.role,
                health: player.health,
                hand: player.hand,
                inPlay: player.inPlay)
    }
}

private extension GHit {
    static func copy(_ hit: HitProtocol) -> GHit {
        GHit(player: hit.player,
             name: hit.name,
             abilities: hit.abilities,
             offender: hit.offender,
             cancelable: hit.cancelable,
             target: hit.target)
    }
}
