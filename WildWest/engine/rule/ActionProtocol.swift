//
//  ActionProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol ActionProtocol {
    var actorId: String { get }
    var cardId: String { get }
    var description: String { get }
    var autoPlay: Bool { get }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol]
}

struct Action: ActionProtocol {
    let actorId: String
    let cardId: String
    let autoPlay: Bool
    let description: String
    let updates: [GameUpdateProtocol]
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        updates
    }
}
