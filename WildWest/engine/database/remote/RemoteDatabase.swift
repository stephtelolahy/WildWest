//
//  RemoteDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import RxSwift

class RemoteDatabase {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    init(state: GameStateProtocol) {
        stateSubject = BehaviorSubject(value: state)
        Database.database().createGame(state)
    }
}
