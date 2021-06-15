//
//  MCTS.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 16/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

// Defining n player turn based game state
protocol State {
    associatedtype Move
    
    var turn: Int { get }
    var status: Int { get }
    var possibleMoves: [Move] { get }
    
    func performMove(_ move: Move) -> Self
}

struct MCTS {
    
    private static let defaultIterations = 1000
    
    func findBestMove<T: State>(state: T, iterations: Int = defaultIterations) -> T.Move {
        let rootNode = Node(state: state)
        let player = state.turn
        
        for _ in 0..<iterations {
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
        }
        
        let bestNode = rootNode.children.max { $0.visitCount < $1.visitCount }!
        return bestNode.move!
    }
}

private extension MCTS {
    
    func selectPromisingNode<T: State>(_ rootNode: Node<T>) -> Node<T> {
        var node = rootNode
        while !node.children.isEmpty {
            node = node.children.max { $0.uctValue < $1.uctValue }!
        }
        return node
    }
    
    func expandNode<T: State>(_ node: Node<T>) {
        node.state.possibleMoves.forEach { move in
            let childState = node.state.performMove(move)
            let childNode = Node(state: childState, parent: node, move: move)
            node.children.append(childNode)
        }
    }
    
    func simulateRandomPlayout<T: State>(_ nodeToExplore: Node<T>, player: Int) -> Int {
        
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
            node = Node(state: childState)
        }
        
        if status == player {
            return 1
        } else {
            return 0
        }
    }
    
    func backPropogation<T: State>(_ nodeToExplore: Node<T>, result: Int) {
        var node: Node<T>? = nodeToExplore
        while node != nil {
            node?.visitCount += 1
            node?.winCount += result
            node = node?.parent
        }
    }
}

extension MCTS {
    class Node<T: State> {
        let state: T
        let parent: Node?
        let move: T.Move?
        var children: [Node] = []
        var visitCount: Int = 0
        var winCount: Int = 0
        
        init(state: T, parent: Node? = nil, move: T.Move? = nil) {
            self.state = state
            self.parent = parent
            self.move = move
        }
    }
}

private extension MCTS.Node {
    
    var uctValue: Double {
        if visitCount == 0 {
            return Double(Int.max)
        }
        
        return Double(winCount) / Double(visitCount)
            + 1.41 * sqrt(log2(Double(parent!.visitCount)) / Double(visitCount))
    }
}

extension MCTS {
    enum Status {
        static let inProgress = -1
        static let draw = 0
        // If status is equal to player then the he wins, otherwise he looses
    }
}
