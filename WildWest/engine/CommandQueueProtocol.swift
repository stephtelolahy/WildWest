//
//  CommandQueueProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 11/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol CommandQueueProtocol {
    var isEmpty: Bool { get }
    
    func add(_ element: GameMove)
    func pull() -> Observable<GameMove>
}
