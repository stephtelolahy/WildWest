//
//  GameSubjectsProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameSubjectsProtocol {
    var allPlayers: [PlayerProtocol] { get }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol>
    func executedMove() -> Observable<GameMove>
    func executedUpdate() -> Observable<GameUpdate>
    func validMoves(for playerId: String) -> Observable<[GameMove]>
    
    func emitExecutedUpdate(_ update: GameUpdate)
    func emitExecutedMove(_ move: GameMove)
    func emitValidMoves(_ moves: [GameMove])
}
