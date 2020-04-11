//
//  GameEngineProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameEngineProtocol {
    var allPlayersCount: Int { get }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol>
    func validMoves(for playerId: String) -> Observable<[GameMove]>
    func executedMove() -> Observable<GameMove>
    
    func start()
    func queue(_ move: GameMove)
}

protocol InternalGameEngineProtocol {
    func execute(_ move: GameMove)
    func emitState(_ state: GameStateProtocol)
    func emitExecutedMove(_ move: GameMove)
    func emitValidMoves(_ moves: [String: [GameMove]])
}
