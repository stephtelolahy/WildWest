//
//  MoveSelector.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 15/11/2020.
//

public struct MoveNode: Equatable {
    public let name: String
    public let value: MoveNodeValue
    
    public init(name: String, value: MoveNodeValue) {
        self.name = name
        self.value = value
    }
    
    public enum MoveNodeValue: Equatable {
        case move(GMove)
        case options([MoveNode])
    }
}

public protocol MoveSelectorProtocol {
    func select(_ moves: [GMove]) -> MoveNode
}

public class MoveSelector: MoveSelectorProtocol {
    
    public init() {
    }
    
    public func select(_ moves: [GMove]) -> MoveNode {
        let refMove = moves[0]
        
        if moves.allSatisfy({ $0.ability == refMove.ability && $0.card == refMove.card }) {
            // same ability
            let name: String
            if case let .hand(card) = refMove.card {
                name = card
            } else {
                name = refMove.ability
            }
            
            if moves.allSatisfy({ $0.args.isEmpty }) {
                // no args, assume unique
                return MoveNode(name: name, value: .move(refMove))
                
            } else if moves.allSatisfy({ $0.args.keys.count == 1 }) {
                // single arg
                return MoveNode(name: name, value: .options(moves.mapNodes(named: { $0.argsString() })))
                
            } else if moves.allSatisfy({ $0.args.keys.count == 2 }) {
                // two args
                let argKeys = refMove.args.keys.sorted(by: { $0 < $1 })
                let key1 = argKeys[0]
                let key2 = argKeys[1]
                
                let nodes: [MoveNode] = moves.uniqueArgValues(for: key1).map { value1 in
                    let relatedMoves = moves.filter { $0.args[key1] == value1 }
                    return MoveNode(name: value1.joined(separator: ", "),
                                    value: .options(relatedMoves.mapNodes(named: { $0.args[key2]!.joined(separator: ", ") })))
                }
                
                return MoveNode(name: name, value: .options(nodes))
                
            } else {
                // other args combination
                fatalError("Unsupported args combination")
            }
            
        } else {
            // different abilities
            let nodes = moves.mapNodes(named: { move in
                if !move.args.isEmpty {
                    return "\(move.ability) \(move.argsString())"
                } else if case let .hand(card) = move.card {
                    return card  
                } else {
                    return move.ability
                }
            })
            return MoveNode(name: "Play", value: .options(nodes))
        }
    }
}

private extension Array where Element == GMove {
    
    func mapNodes(named transform: (Element) -> String) -> [MoveNode] {
        map { MoveNode(name: transform($0), value: .move($0)) }
    }
    
    func uniqueArgValues(for key: PlayArg) -> [[String]] {
        var result: [[String]] = []
        for move in self {
            if let value = move.args[key],
               !result.contains(value) {
                result.append(value)
            }
        }
        return result
    }
}

private extension GMove {
    func argsString(_ playArgs: [PlayArg] = [.target, .requiredInPlay, .requiredHand, .requiredStore, .requiredDeck]) -> String {
        playArgs.compactMap { args[$0] }.flatMap { $0 }.joined(separator: ", ")
    }
}

extension PlayArg: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        allCases.firstIndex(of: lhs)! < allCases.firstIndex(of: rhs)!
    }
}
