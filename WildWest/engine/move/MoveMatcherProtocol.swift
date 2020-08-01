//
//  MoveMatcherProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// Function matching state to moves
protocol MoveMatcherProtocol {
    func moves(matching state: GameStateProtocol) -> [GameMove]?
    func autoPlay(matching state: GameStateProtocol) -> GameMove?
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?
}

extension MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        nil
    }
    
    func autoPlay(matching state: GameStateProtocol) -> GameMove? {
        nil
    }
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        nil
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        nil
    }
}
