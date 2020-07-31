//
//  GameEnvironment.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameEnvironment {
    let engine: GameEngineProtocol
    let subjects: GameSubjectsProtocol
    let controlledId: String?
    let aiAgents: [AIPlayerAgentProtocol]?
    var gameUsers: [String: WUserInfo]?
}
