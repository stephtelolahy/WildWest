//
//  MoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 11/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

struct MoveSelection {
    let title: String
    let options: [String]
}

protocol MoveSelectorProtocol {
    func select(active moves: [GMove]) -> MoveSelection?
    func select(reactionTo hit: String, moves: [GMove]) -> MoveSelection?
}

class MoveSelector: MoveSelectorProtocol {
    
    func select(active moves: [GMove]) -> MoveSelection? {
        guard !moves.isEmpty else {
            return nil
        }
        
        let refMove = moves[0]
        if moves.allSatisfy({ $0.name == refMove.name }) {
            if case let .hand(refCard) = refMove.card,
               moves.allSatisfy({ $0.card == .hand(refCard) }) {
                return MoveSelection(title: refCard, 
                                     options: moves.map { $0.argsString() })
            } else if let refCard = refMove.args[.requiredHand]?.first, 
                      moves.allSatisfy({ $0.args[.requiredHand] == refMove.args[.requiredHand] }) {
                return MoveSelection(title: refCard, 
                                     options: moves.map { $0.argsString([.target]) })
            } else {
                return MoveSelection(title: refMove.name, 
                                     options: moves.map { $0.argsString() })
            }
        } else {
            let title = "Select move"
            let options: [String] = moves.map {
                let argString = $0.argsString()
                if !argString.isEmpty {
                    return "\($0.name) \(argString)"
                } else {
                    return $0.name
                }
            }
            return MoveSelection(title: title,
                                 options: options)
        }
    }
    
    func select(reactionTo hit: String, moves: [GMove]) -> MoveSelection? {
        guard !moves.isEmpty else {
            return nil
        }
        
        let options: [String] = moves.map {
            let argString = $0.argsString()
            if !argString.isEmpty {
                return argString
            } else if case let .hand(card) = $0.card {
                return card
            } else {
                return $0.name
            }
        }
        return MoveSelection(title: hit,
                             options: options)
    }
}

private extension GMove {
    func argsString(_ playArgs: [PlayArg] = [.target, .requiredInPlay, .requiredHand, .requiredStore]) -> String {
        var flatValues: [String] = []
        playArgs.forEach { key in
            if let values = args[key] {
                flatValues.append(contentsOf: values)
            }
        }
        return flatValues.joined(separator: ", ")
    }
}
