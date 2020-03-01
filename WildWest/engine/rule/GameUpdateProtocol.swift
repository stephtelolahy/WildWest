//
//  GameUpdateProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameUpdateProtocol {
    var description: String { get }
    
    func execute(in database: GameDatabaseProtocol)
}
