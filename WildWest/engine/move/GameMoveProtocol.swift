//
//  GameMoveProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// A concrete action performed by a player or the game itself
enum GameMove: Equatable {
    case startTurn(actorId: String)
}

/// Function defining valid player move regarding given state
protocol ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [String: [GameMove]]?
}

/// Function defining automatic player move regarding given state
protocol AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]?
}

// Function defining effect after playing given move
protocol EffectMatcherProtocol {
    func effects(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?
}

// Function defining game updates on executing move
protocol MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?
}
