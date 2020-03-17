//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct PlayerItem {
    let player: PlayerProtocol
    let isActive: Bool
    let isTurn: Bool
    let isEliminated: Bool
    let isRevealed: Bool
    let isControlled: Bool
}

enum PlayersAdapter {
    static func buildItems(state: GameStateProtocol,
                           for controlledPlayerId: String?,
                           playerIndexes: [Int: String]) -> [PlayerItem?] {
        Array(0..<MapConfiguration.itemsCount).map { index in
            guard let playerId = playerIndexes[index] else {
                return nil
            }
            
            if let eliminatedPlayer = state.eliminated.first(where: { $0.identifier == playerId }) {
                return PlayerItem(player: eliminatedPlayer,
                                  isActive: false,
                                  isTurn: false,
                                  isEliminated: true,
                                  isRevealed: true,
                                  isControlled: false)
            }
            
            if let player = state.players.first(where: { $0.identifier == playerId }) {
                let isActive = state.validMoves[playerId] != nil
                let isTurn = player.identifier == state.turn
                let isRevealed = state.outcome != nil
                    || player.role == .sheriff
                    || player.identifier == controlledPlayerId
                return PlayerItem(player: player,
                                  isActive: isActive,
                                  isTurn: isTurn,
                                  isEliminated: false,
                                  isRevealed: isRevealed,
                                  isControlled: player.identifier == controlledPlayerId)
            }
            
            return nil
        }
    }
}

enum MapConfiguration {
    
    static let itemsCount = 9
    
    private static let configuration: [[Int]] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 2, 0, 0, 0],
        [1, 0, 2, 0, 0, 0, 0, 3, 0],
        [1, 0, 2, 0, 0, 0, 4, 0, 3],
        [1, 2, 3, 0, 0, 0, 5, 0, 4],
        [1, 0, 2, 6, 0, 3, 5, 0, 4],
        [1, 2, 3, 7, 0, 4, 6, 0, 5]
    ]
    
    static func buildIndexes(with playerIds: [String]) -> [Int: String] {
        var result: [Int: String] = [:]
        let indexes = configuration[playerIds.count]
        for (index, element) in indexes.enumerated() where element > 0 {
            result[index] = playerIds[element - 1]
        }
        return result
    }
}
