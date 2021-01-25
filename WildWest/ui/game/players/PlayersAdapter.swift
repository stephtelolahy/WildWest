//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
import WildWestEngine

struct PlayerItem {
    let player: PlayerProtocol
    let isTurn: Bool
    let isAttacked: Bool
    let isHelped: Bool
    let score: Int?
    let user: UserInfo?
}

protocol PlayersAdapterProtocol {
    func setUsers(_ users: [String: UserInfo])
    func buildItems(state: StateProtocol) -> [PlayerItem]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    private var users: [String: UserInfo] = [:]
    
    func setUsers(_ users: [String: UserInfo]) {
        self.users = users
    }
    
    func buildItems(state: StateProtocol) -> [PlayerItem] {
        state.initialOrder.map { player in
            PlayerItem(player: state.players[player]!,
                       isTurn: player == state.turn,
                       isAttacked: state.hits.contains(where: { $0.player == player }),
                       isHelped: false,
                       score: 0,
                       user: users[player])
        }
    }
}
