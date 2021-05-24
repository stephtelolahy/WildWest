//
//  PlayArg+Extension.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//


extension Array where Element == [PlayArg: [String]] {
    
    mutating func appending(values: [String], by count: Int = 1, forArg arg: PlayArg) -> Bool {
        let argValues = values.combine(by: count)
        guard !argValues.isEmpty else {
            return false
        }
        
        var oldArgs = self
        if oldArgs.isEmpty {
            oldArgs = [[:]]
        }
        self = []
        
        for oldArg in oldArgs {
            for value in argValues {
                var dict = oldArg
                dict[arg] = value
                self.append(dict)
            }
        }
        
        return true
    }
    
    mutating func appendingRequiredInPlay(state: StateProtocol) -> Bool {
        var oldArgs = self
        if oldArgs.isEmpty {
            oldArgs = [[:]]
        }
        self = []
        
        for oldArg in oldArgs {
            guard let target = oldArg[.target]?.first else {
                return false
            }
            
            let cards = state.players[target]!.inPlay.map { $0.identifier }
            guard !cards.isEmpty else {
                continue
            }
            
            for card in cards {
                var dict = oldArg
                dict[.requiredInPlay] = [card]
                self.append(dict)
            }
        }
        
        return !self.isEmpty
    }
}

