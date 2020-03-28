//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct PlayerItem {
    let player: PlayerProtocol
    let isControlled: Bool
    let isTurn: Bool
    let isAttacked: Bool
    let isHelped: Bool
    let isEliminated: Bool
    let score: Int?
}

protocol PlayersAdapterProtocol {
    func buildIndexes(playerIds: [String], controlledId: String?) -> [Int: String]
    func buildItems(state: GameStateProtocol,
                    for controlledPlayerId: String?,
                    playerIndexes: [Int: String],
                    antiSheriffScore: [String: Int]) -> [PlayerItem?]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    func buildItems(state: GameStateProtocol,
                    for controlledPlayerId: String?,
                    playerIndexes: [Int: String],
                    antiSheriffScore: [String: Int]) -> [PlayerItem?] {
        Array(0..<9).map { index in
            guard let playerId = playerIndexes[index] else {
                return nil
            }
            
            if let eliminatedPlayer = state.eliminated.first(where: { $0.identifier == playerId }) {
                return PlayerItem(player: eliminatedPlayer,
                                  isControlled: false,
                                  isTurn: false,
                                  isAttacked: false,
                                  isHelped: false,
                                  isEliminated: true,
                                  score: antiSheriffScore[playerId])
            }
            
            if let player = state.players.first(where: { $0.identifier == playerId }) {
                return PlayerItem(player: player,
                                  isControlled: player.identifier == controlledPlayerId,
                                  isTurn: player.identifier == state.turn,
                                  isAttacked: state.isPlayerAttacked(playerId),
                                  isHelped: state.isPlayerHelped(playerId),
                                  isEliminated: false,
                                  score: antiSheriffScore[playerId])
            }
            
            return nil
        }
    }
    
    func buildIndexes(playerIds: [String], controlledId: String?) -> [Int: String] {
        let configuration: [[Int]] = [
            [0, 0, 0, 0, 0, 0, 0, 0, 0], // 0 player
            [0, 0, 0, 0, 0, 0, 0, 1, 0], // 1 player
            [0, 2, 0, 0, 0, 0, 0, 1, 0], // 2 players
            [2, 0, 3, 0, 0, 0, 0, 1, 0], // 3 players
            [0, 3, 0, 2, 0, 4, 0, 1, 0], // 4 players
            [3, 0, 4, 2, 0, 5, 0, 1, 0], // 5 players
            [3, 4, 5, 2, 0, 6, 0, 1, 0], // 6 players
            [4, 5, 6, 3, 0, 7, 2, 1, 0]  // 7 players
        ]
        
        var shiftedIds = playerIds
        if shiftedIds.contains(where: { $0 == controlledId }) {
            while shiftedIds[0] != controlledId {
                shiftedIds.append(shiftedIds.remove(at: 0))
            }
        }
        
        var result: [Int: String] = [:]
        let indexes = configuration[playerIds.count]
        for (index, element) in indexes.enumerated() where element > 0 {
            result[index] = shiftedIds[element - 1]
        }
        return result
    }
}

private extension GameStateProtocol {
    
    func isPlayerAttacked(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge {
            case let .duel(playerIds, _):
                return playerIds.first == playerId
                
            case let .indians(targetIds, _):
                return targetIds.contains(playerId)
                
            case let .shoot(targetIds, _, _):
                return targetIds.contains(playerId)
                
            case .dynamiteExploded:
                return turn == playerId
                
            default:
                return false
            }
        }
        
        let classifier = MoveClassifier()
        if let lastMove = executedMoves.last {
            let classification = classifier.classify(lastMove)
            switch classification {
            case let .strongAttack(_, targetId):
                return targetId == playerId
                
            case let .weakAttack(_, targetId):
                return targetId == playerId
                
            default:
                return false
            }
        }
        
        return false
    }
    
    func isPlayerHelped(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge {
            case let .generalStore(playerIds):
                return playerIds.contains(playerId)
                
            default:
                return false
            }
        }
        
        let classifier = MoveClassifier()
        if let lastMove = executedMoves.last {
            let classification = classifier.classify(lastMove)
            switch classification {
            case let .help(_, targetId):
                return targetId == playerId
                
            default:
                return false
            }
        }
        
        return false
    }
}
