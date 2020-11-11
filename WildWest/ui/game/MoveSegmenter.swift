//
//  MoveSegmenter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 11/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

protocol MoveSegmenterProtocol {
    func segment(_ moves: [GMove]) -> [String: [GMove]]
}

class MoveSegmenter: MoveSegmenterProtocol {
    
    func segment(_ moves: [GMove]) -> [String: [GMove]] {
        let endTurn = "endTurn"
        let other = "*"
        var result: [String: [GMove]] = [:]
        moves.forEach { move in
            if case let .hand(card) = move.card {
                result.append(move, forKey: card)
            } else if let requiredHand = move.args[.requiredHand],
                      requiredHand.count == 1 {
                result.append(move, forKey: requiredHand[0])
            } else if move.name == endTurn {
                result.append(move, forKey: endTurn)
            } else {
                result.append(move, forKey: other)
            }
        }
        return result
    }
}

private extension Dictionary where Key == String, Value == [GMove] {
    mutating func append(_ value: GMove, forKey key: String) {
        if let previousValue = self[key] {
            self[key] = previousValue + [value]
        } else {
            self[key] = [value]
        }
    }
}
