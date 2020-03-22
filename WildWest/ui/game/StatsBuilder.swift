//
//  StatsBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol StatsBuilder {
    func buildAntiSheriffScore(state: GameStateProtocol) -> [AgressivityStat]
}

class AgressivityStat {
    let source: String
    let target: String
    var value: Int
    
    init(source: String, target: String, value: Int) {
        self.source = source
        self.target = target
        self.value = value
    }
}

extension StatsBuilder {
    func buildAntiSheriffScore(state: GameStateProtocol) -> [AgressivityStat] {
        let allPlayers = state.players + state.eliminated
        guard let sheriff = allPlayers.first(where: { $0.role == .sheriff }) else {
            return []
        }
        
        let otherPlayers = allPlayers.filter { $0.role != .sheriff }
        var stats = otherPlayers.map { AgressivityStat(source: $0.identifier, target: sheriff.identifier, value: 0) }
        
        let classifier = MoveClassifier()
        state.executedMoves.forEach { move in
            
            let classification = classifier.classify(move)
            switch classification {
            case let .strongAttack(actorId, targetId):
                stats.append(Score.strongAttackEnemy, from: actorId, to: targetId)
                
            case let .weakAttack(actorId, targetId):
                stats.append(Score.weakAttackEnemy, from: actorId, to: targetId)
                
            case let .help(actorId, targetId):
                stats.append(Score.helpEnemy, from: actorId, to: targetId)
                
            default:
                break
            }
        }
        
        return stats.sorted(by: { $0.value > $1.value })
    }
}

private extension Array where Element == AgressivityStat {
    mutating func append(_ value: Int, from actorId: String, to targetId: String) {
        first(where: { $0.source == actorId && $0.target == targetId })?.value += value
    }
}
