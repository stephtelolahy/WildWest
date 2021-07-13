//
//  MCTS.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 16/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

// Defining n player turn based game state
public protocol MCTSState {
    associatedtype MCTSMove
    
    var player: Int { get }
    var status: Int { get }
    var possibleMoves: [MCTSMove] { get }
    
    func performMove(_ move: MCTSMove) -> Self
}

public struct MCTS {
    
    func findBestMove<T: MCTSState>(state: T, duration: TimeInterval = 0.1) -> T.MCTSMove {
        let rootNode = MCTSNode(state: state)
        let player = state.player
        
        let start = Date()
        while true {
            // Phase 1 - Selection
            var nodeToExplore = selectPromisingNode(rootNode)
            
            // Phase 2 - Expansion
            if nodeToExplore.state.status == Status.inProgress {
                expandNode(nodeToExplore)
                nodeToExplore = nodeToExplore.children.randomElement()!
            }
            
            // Phase 3 - Simulation
            let playoutResult = simulateRandomPlayout(nodeToExplore, player: player)
            
            // Phase 4 - Update
            backPropogation(nodeToExplore, result: playoutResult)
            
            // check time elapsed
            let end = Date()
            let time = end.timeIntervalSince(start)
            if time > duration {
                break
            }
        }
        
        let bestNode = rootNode.children.max { $0.visitCount < $1.visitCount }!
        return bestNode.move!
    }
}

private extension MCTS {
    
    func selectPromisingNode<T: MCTSState>(_ rootNode: MCTSNode<T>) -> MCTSNode<T> {
        var node = rootNode
        while !node.children.isEmpty {
            node = node.children.max { $0.uctValue < $1.uctValue }!
        }
        return node
    }
    
    func expandNode<T: MCTSState>(_ node: MCTSNode<T>) {
        node.state.possibleMoves.forEach { move in
            let childState = node.state.performMove(move)
            let childNode = MCTSNode(state: childState, parent: node, move: move)
            node.children.append(childNode)
        }
    }
    
    func simulateRandomPlayout<T: MCTSState>(_ nodeToExplore: MCTSNode<T>, player: Int) -> Int {
        
        var status = nodeToExplore.state.status
        // Opponent wins
        if status != Status.inProgress,
           status != Status.draw,
           status != player {
            /*
             https://medium.com/swlh/tic-tac-toe-at-the-monte-carlo-a5e0394c7bc2
             If the node results in an opponent’s victory,
             it would mean that if the player had made the selected move,
             his opponent will have a subsequent move
             that can result in the opponents immediete victory.
             Because the move the player chose can lead to a definite loss,
             the function lowers the parents node’s winScore to the lowest possible integer
             to prevent future moves to that node.
             Otherwise the algorithm alternates random moves between the two player
             until the board results in a game ending state.
             The function then returns the final game status.
             */
            nodeToExplore.parent?.winCount = Int.min
            return 0
        }
        
        var node = nodeToExplore
        while status == Status.inProgress {
            let randomMove = node.state.possibleMoves.randomElement()!
            let childState = node.state.performMove(randomMove)
            status = childState.status
            node = MCTSNode(state: childState)
        }
        
        if status == player {
            return 1
        } else {
            return 0
        }
    }
    
    func backPropogation<T: MCTSState>(_ nodeToExplore: MCTSNode<T>, result: Int) {
        var node: MCTSNode<T>? = nodeToExplore
        while node != nil {
            node?.visitCount += 1
            node?.winCount += result
            node = node?.parent
        }
    }
}

class MCTSNode<T: MCTSState> {
    let state: T
    let parent: MCTSNode?
    let move: T.MCTSMove?
    var children: [MCTSNode] = []
    var visitCount: Int = 0
    var winCount: Int = 0
    
    init(state: T, parent: MCTSNode? = nil, move: T.MCTSMove? = nil) {
        self.state = state
        self.parent = parent
        self.move = move
    }
}

private extension MCTSNode {
    var uctValue: Double {
        if visitCount == 0 {
            return Double(Int.max)
        }
        
        return Double(winCount) / Double(visitCount)
            + 1.41 * sqrt(log2(Double(parent!.visitCount)) / Double(visitCount))
    }
}

public extension MCTS {
    enum Status {
        public static let inProgress = -1
        public static let draw = 0
        // If status is equal to player then the he wins, otherwise he looses
    }
}
