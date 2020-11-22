//
//  InstructionBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
import CardGameEngine

protocol InstructionBuilderProtocol {
    func buildInstruction(state: StateProtocol, for controlledPlayerId: String?) -> String
}

class InstructionBuilder: InstructionBuilderProtocol {
    func buildInstruction(state: StateProtocol, for controlledPlayerId: String?) -> String {
        if controlledPlayerId == nil {
            return "viewing game"
        } else if controlledPlayerId != state.turn {
            return "waiting others to play"
        } else {
            return "play any card"
        }
    }
}
