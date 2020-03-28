//
//  Score.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum Score {
    static let endTurn = -1
    static let pass = -1
    static let useLowerRangeGun = -1
    static let strongAttackEnemy = 3
    static let strongAttackTeammate = -3
    static let strongAttackUnknown = 0
    static let weakAttackEnemy = 1
    static let weakAttackTeammate = -1
    static let weakAttackUnknown = 0
    static let helpTeammate = 1
    static let helpEnemy = -3
    static let helpUnknown = -2
}
