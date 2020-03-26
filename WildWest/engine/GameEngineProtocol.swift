//
//  GameEngineProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameEngineProtocol {
    func start()
    func queue(_ move: GameMove)
    func observeAs(playerId: String?) -> Observable<GameStateProtocol>
}
