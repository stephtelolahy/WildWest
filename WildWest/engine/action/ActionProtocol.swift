//
//  ActionProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol ActionProtocol {
    var actorId: String { get }
    var description: String { get }
    
    func execute(state: GameStateProtocol)
}
