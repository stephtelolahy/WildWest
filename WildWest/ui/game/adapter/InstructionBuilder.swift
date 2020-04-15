//
//  InstructionBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol InstructionBuilderProtocol {
    func buildInstruction(state: GameStateProtocol, for controlledPlayerId: String?) -> String
}

class InstructionBuilder: InstructionBuilderProtocol {
    func buildInstruction(state: GameStateProtocol, for controlledPlayerId: String?) -> String {
        if let outcome = state.outcome {
            return outcome.rawValue
        }
        
        if controlledPlayerId == nil {
            return "viewing game"
        }
        
        if controlledPlayerId != state.turn {
            return "waiting others to play"
        }
        
        if let challenge = state.challenge {
            return challenge.name.rawValue
        }
        
        return "play any card"
    }
}
