//
//  Score.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable operator_usage_whitespace

enum Score {
    static let strongAttackEnemy    = 3
    static let helpTeammate         = 1
    static let weakAttackEnemy      = 1
    static let weakAttackUnknown    = 0
    static let strongAttackUnknown  = 0
    static let pass                 = -1
    static let endTurn              = -1
    static let weakAttackTeammate   = -2
    static let helpUnknown          = -2
    static let helpEnemy            = -2
    static let strongAttackTeammate = -2
}
