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
    func buildItems(state: StateProtocol,
                    scores: [String: Int]) -> [PlayerItem]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    private var users: [String: WUserInfo] = [:]
    
    func setUsers(_ users: [String: WUserInfo]) {
        self.users = users
    }
    
    func buildItems(state: StateProtocol,
                    scores: [String: Int]) -> [PlayerItem] {
        state.initialOrder.map { player in
            PlayerItem(player: state.players[player]!,
                       isTurn: player == state.turn,
                       isAttacked: false,
                       isHelped: false,
                       score: scores[player],
                       user: users[player])
        }
    }
}
/*
private extension StateProtocol {
    
    func isPlayerAttacked(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge.name {
            case .bang, .gatling, .indians:
                return challenge.targetIds?.contains(playerId) == true
                
            case .duel:
                return challenge.targetIds?.first == playerId
                
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
                return  challenge.targetIds?.contains(playerId) == true
                
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
*/
