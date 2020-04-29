//
//  GameContext.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameContext {
    let engine: GameEngineProtocol
    let subjects: GameSubjectsProtocol
    let aiAgents: [AIPlayerAgentProtocol]
    
    init(engine: GameEngineProtocol,
         subjects: GameSubjectsProtocol,
         aiAgents: [AIPlayerAgentProtocol]) {
        self.engine = engine
        self.subjects = subjects
        self.aiAgents = aiAgents
    }
}
