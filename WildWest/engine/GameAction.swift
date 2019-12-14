//
//  GameAction.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/13/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameActionProtocol {
    func execute() -> [GameUpdateProtocol]
}
