//
//  GameEnvironment.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import WildWestEngine

struct GameEnvironment {
    let engine: EngineProtocol
    let database: RestrictedDatabaseProtocol
    let controlledId: String?
    let aiAgents: [AIAgentProtocol]?
    var gameUsers: [String: WUserInfo]?
}
