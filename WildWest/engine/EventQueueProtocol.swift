//
//  EventQueueProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol EventQueueProtocol {
    var isEmpty: Bool { get }
    
    func pop() -> Observable<GameEvent> // get and remove element at the top of the queue
    func push(_ element: GameEvent) // push element on the top of the queue
    func add(_ element: GameEvent) // add elements at the tail of queue
}

struct GameEvent: Equatable {
    let move: GameMove
    var updateGroups: [[GameUpdate]]?
}
