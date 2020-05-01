//
//  GameSubjectsProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameSubjectsProtocol {
    var sheriffId: String { get }
    
    func playerIds(observedBy playerId: String?) -> [String]
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol>
    func executedMove() -> Observable<GameMove>
    func executedUpdate() -> Observable<GameUpdate>
    func validMoves(for playerId: String) -> Observable<[GameMove]>
}
