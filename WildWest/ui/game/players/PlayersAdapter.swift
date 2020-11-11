//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
import CardGameEngine

struct PlayerItem {
    let player: PlayerProtocol
    let isTurn: Bool
    let isAttacked: Bool
    let isHelped: Bool
    let score: Int?
    let user: WUserInfo?
}

protocol PlayersAdapterProtocol {
    func setUsers(_ users: [String: WUserInfo])
    func buildItems(state: StateProtocol) -> [PlayerItem]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    private var users: [String: WUserInfo] = [:]
    
    func setUsers(_ users: [String: WUserInfo]) {
        self.users = users
    }
    
    func buildItems(state: StateProtocol) -> [PlayerItem] {
        state.initialOrder.map { player in
            PlayerItem(player: state.players[player]!,
                       isTurn: player == state.turn,
                       isAttacked: state.hits.first?.player == player,
                       isHelped: false,
                       score: 0,
                       user: users[player])
        }
    }
}
