//
//  MoveContext.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public struct MoveContext {
    let ability: String
    let actor: PlayerProtocol
    let card: PlayCard?
    let state: StateProtocol
    let event: GEvent?
    var args: [PlayArg: [String]] = [:]
}
