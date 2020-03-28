//
//  MoveMatcherProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// Function matching state to moves
protocol MoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]?
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]?
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?
}

extension MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        nil
    }
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        nil
    }
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        nil
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        nil
    }
}
