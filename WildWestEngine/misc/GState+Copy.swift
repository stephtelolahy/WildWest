//
//  GState+Copy.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 15/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

extension GState {
    static func copy(_ state: StateProtocol) -> GState {
        var hitCopy: HitProtocol?
        if let hit = state.hit {
            hitCopy = GHit.copy(hit)
        }
        
        return GState(players: state.players.mapValues { GPlayer.copy($0) },
                      initialOrder: state.initialOrder,
                      playOrder: state.playOrder,
                      turn: state.turn,
                      phase: state.phase,
                      deck: state.deck,
                      discard: state.discard,
                      store: state.store,
                      hit: hitCopy,
                      played: state.played,
                      history: state.history,
                      winner: state.winner)
    }
}

extension GPlayer {
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

extension GHit {
    static func copy(_ hit: HitProtocol) -> GHit {
        GHit(name: hit.name,
             players: hit.players,
             abilities: hit.abilities,
             cancelable: hit.cancelable,
             targets: hit.targets)
    }
}
