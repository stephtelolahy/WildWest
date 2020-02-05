//
//  GenericAction.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 03/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GenericAction {
    let name: String
    let actorId: String
    let cardId: String?
    let options: [ActionProtocol]
}
