//
//  OnQueueEmpty.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When events queue is empty
 */
class OnQueueEmpty: PlayReq {
    
    override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case .emptyQueue = ctx.event else {
            return false
        }
        return true
    }
}
