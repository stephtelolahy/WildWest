//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

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
    func buildItems(state: GameStateProtocol,
                    latestMove: GameMove?,
                    scores: [String: Int]) -> [PlayerItem]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    private var users: [String: WUserInfo] = [:]
    
    func setUsers(_ users: [String: WUserInfo]) {
        self.users = users
    }
    
    func buildItems(state: GameStateProtocol,
                    latestMove: GameMove?,
                    scores: [String: Int]) -> [PlayerItem] {
        state.allPlayers.map { player in
            let playerId = player.identifier
            let isAttacked = state.isPlayerAttacked(playerId) || latestMove?.isPlayerAttacked(playerId) == true
            let isHelped = state.isPlayerHelped(playerId) || latestMove?.isPlayerHelped(playerId) == true
            return PlayerItem(player: player,
                              isTurn: player.identifier == state.turn,
                              isAttacked: isAttacked,
                              isHelped: isHelped,
                              score: scores[playerId],
                              user: users[player.identifier])
        }
    }
}

private extension GameStateProtocol {
    
    func isPlayerAttacked(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge.name {
            case .bang, .gatling, .indians:
                return challenge.targetIds.contains(playerId)
                
            case .duel:
                return challenge.targetIds.first == playerId
                
            case .dynamiteExploded:
                return turn == playerId
                
            default:
                return false
            }
        }
        return false
    }
    
    func isPlayerHelped(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge.name {
            case .generalStore:
                return  challenge.targetIds.contains(playerId)
                
            default:
                return false
            }
        }
        return false
    }
}

private extension GameMove {
    
    func isPlayerAttacked(_ playerId: String) -> Bool {
        switch MoveClassifier().classify(self) {
        case let .strongAttack(_, targetId):
            return targetId == playerId
            
        case let .weakAttack(_, targetId):
            return targetId == playerId
            
        default:
            return false
        }
    }
    
    func isPlayerHelped(_ playerId: String) -> Bool {
        if case .saloon = name {
            return true
        }
        
        switch MoveClassifier().classify(self) {
        case let .help(_, targetId):
            return targetId == playerId
            
        default:
            return false
        }
    }
}
