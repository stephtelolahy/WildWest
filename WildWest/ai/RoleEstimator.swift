//
//  RoleEstimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/08/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol RoleEstimatorProtoccol {
    func estimateRole(for playerId: String) -> Role?
}

class RoleEstimator: RoleEstimatorProtoccol {
    
    private let statsBuilder: StatsBuilderProtocol
    
    init(statsBuilder: StatsBuilderProtocol) {
        self.statsBuilder = statsBuilder
    }
    
    func estimateRole(for playerId: String) -> Role? {
        // if attacked sheriff at least once,
        // then estimated role is outlaw
        if let score = statsBuilder.scores[playerId],
            score > 0 {
            return .outlaw
        }
        
        return nil
    }
}
