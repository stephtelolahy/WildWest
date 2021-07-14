//
//  MoveSelector.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 15/11/2020.
//

public protocol MoveSelectorProtocol {
    func select(_ moves: [GMove], suggestedTitle: String?) -> Node<GMove>
}

public class MoveSelector: MoveSelectorProtocol {
    
    public init() {
    }
    
    public func select(_ moves: [GMove], suggestedTitle: String?) -> Node<GMove> {
        let refMove = moves[0]
        
        if moves.allSatisfy({ $0.ability == refMove.ability }) {
            // same ability
            if moves.allSatisfy({ $0.args.isEmpty }) {
                // no args
                return Node(title: refMove.cardOrAbility, value: refMove)
                
            } else {
                // multiple args
                let argKeys = refMove.args.keys.sorted(by: { $0 < $1 })
                return moves.toNode(title: refMove.cardOrAbility, groupedBy: argKeys)
            }
            
        } else {
            // different abilities
            var title = suggestedTitle ?? ""
            if moves.allSatisfy({ $0.cardOrAbility == refMove.cardOrAbility }) {
                title = refMove.cardOrAbility
            }
            
            if moves.allSatisfy({ $0.args.isEmpty }) {
                // no args
                let children = moves.map { Node(title: $0.cardOrAbility, value: $0) }
                return Node(title: title, children: children)
                
            } else {
                // split by ability
                let children = moves.uniqueAbilities().map { ability -> Node<GMove> in
                    let childMoves = moves.filter { $0.ability == ability }
                    
                    // no args
                    if childMoves.count == 1,
                       childMoves[0].args.isEmpty {
                        return Node(title: ability, value: childMoves[0])
                    } else {
                        let argKeys = childMoves[0].args.keys.sorted(by: { $0 < $1 })
                        return childMoves.toNode(title: ability, groupedBy: argKeys)
                    }
                }
                return Node(title: title, children: children)
            }
        }
    }
}

private extension Array where Element == GMove {
    
    func toNode(title: String, groupedBy keys: [PlayArg]) -> Node<GMove> {
        guard keys.count > 1 else {
            let children = self.map { Node(title: $0.argsString(keys), value: $0) }
            return Node(title: title, children: children)
        }
        
        var remainingKeys = keys
        let firstKey = remainingKeys.remove(at: 0)
        let children: [Node<GMove>] = self.uniqueValues(for: firstKey).map { value in
            let childMoves = self.filter { $0.args[firstKey] == value }
            return childMoves.toNode(title: value.joined(separator: ", "), groupedBy: remainingKeys)
        }
        return Node(title: title, children: children)
    }
    
    func uniqueValues(for key: PlayArg) -> [[String]] {
        var result: [[String]] = []
        for move in self {
            if let value = move.args[key],
               !result.contains(value) {
                result.append(value)
            }
        }
        return result
    }
    
    func uniqueAbilities() -> [String] {
        var result: [String] = []
        for move in self {
            if !result.contains(move.ability) {
                result.append(move.ability)
            }
        }
        return result
    }
}

private extension GMove {
    
    var cardOrAbility: String {
        if case let .hand(card) = card {
            return card
        } else {
            return ability
        }
    }
    
    func argsString(_ playArgs: [PlayArg] = PlayArg.allCases) -> String {
        playArgs.compactMap { args[$0] }.flatMap { $0 }.joined(separator: ", ")
    }
}

extension PlayArg: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        allCases.firstIndex(of: lhs)! < allCases.firstIndex(of: rhs)!
    }
}
