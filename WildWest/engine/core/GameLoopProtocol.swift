//
//  GameLoopProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameLoopProtocol {
    func start(move: GameMove, completed: @escaping () -> Void)
}
