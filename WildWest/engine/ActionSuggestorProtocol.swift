//
//  ActionSuggestorProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol ActionSuggestorProtocol {
    func actions(matching state: GameStateProtocol) -> [ActionProtocol]
}
