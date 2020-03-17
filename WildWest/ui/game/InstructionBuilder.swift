//
//  InstructionBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol InstructionBuilder {
    func buildInstruction(state: GameStateProtocol, for controlledPlayerId: String?) -> String
}

extension InstructionBuilder {
    func buildInstruction(state: GameStateProtocol, for controlledPlayerId: String?) -> String {
        if let outcome = state.outcome {
            return outcome.rawValue
        }
        
        if let challenge = state.challenge {
            return challenge.description
        }
        
        guard let controlledPlayerId = controlledPlayerId,
            state.validMoves[controlledPlayerId] != nil else {
                return "waiting others to play"
        }
        
        return "play any card"
    }
}

private extension Challenge {
    var description: String {
        switch self {
        case .startTurn:
            return "startTurn"
            
        case .startTurnDynamiteExploded:
            return "dynamiteExploded"
            
        case let .duel(playerIds, _):
            return "duel(\(playerIds.joined(separator: ", ")))"
            
        case let .shoot(playerIds, cardName, _):
            switch cardName {
            case .bang:
                return "bang(\(playerIds.joined(separator: ", ")))"
            case .gatling:
                return "gatling(\(playerIds.joined(separator: ", ")))"
            default:
                return "shoot(\(playerIds.joined(separator: ", ")))"
            }
            
        case let .indians(playerIds, _):
            return "indians(\(playerIds.joined(separator: ", ")))"
            
        case let .generalStore(playerIds):
            return "generalStore(\(playerIds.joined(separator: ", ")))"
        }
    }
}
