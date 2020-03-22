//
//  MoveClassifierProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol MoveClassifierProtocol {
    func classify(_ move: GameMove) -> MoveClassification
}

enum MoveClassification {
    case strongAttack(actorId: String, targetId: String)
    case weakAttack(actorId: String, targetId: String)
    case help(actorId: String, targetId: String)
    case none
}
