//
//  MoveSegmenter.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 15/11/2020.
//

// GRoup moves by input type
// - hand card
// - end turn
// - other
public protocol MoveSegmenterProtocol {
    func segment(_ moves: [GMove]) -> [String: [GMove]]
}

public class MoveSegmenter: MoveSegmenterProtocol {
    
    public init() {
    }
    
    public func segment(_ moves: [GMove]) -> [String: [GMove]] {
        let endTurn = "endTurn"
        let other = "*"
        var result: [String: [GMove]] = [:]
        for move in moves {
            if case let .hand(card) = move.card {
                result.append(move, forKey: card)
            } else if move.ability == endTurn {
                result.append(move, forKey: endTurn)
            } else {
                result.append(move, forKey: other)
            }
        }
        return result
    }
}

extension Dictionary where Key == String, Value == [GMove] {
    mutating func append(_ value: GMove, forKey key: String) {
        if let previousValue = self[key] {
            self[key] = previousValue + [value]
        } else {
            self[key] = [value]
        }
    }
}
