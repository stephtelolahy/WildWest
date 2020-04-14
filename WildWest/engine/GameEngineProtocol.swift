//
//  GameEngineProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameEngineProtocol {
    var allPlayers: [PlayerProtocol] { get }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol>
    func validMoves(for playerId: String) -> Observable<[GameMove]>
    func executedMove() -> Observable<GameMove>
    func executedUpdates() -> Observable<GameUpdate>
    
    func start()
    func execute(_ move: GameMove)
}

protocol InternalGameEngineProtocol {
    func emitState(_ state: GameStateProtocol)
    func emitUpdate(_ update: GameUpdate)
    func emitExecutedMove(_ move: GameMove)
    func emitValidMoves(_ moves: [String: [GameMove]])
}
