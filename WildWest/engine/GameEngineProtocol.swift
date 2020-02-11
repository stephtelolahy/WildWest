//
//  GameEngineProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameEngineProtocol {
    var stateSubject: BehaviorSubject<GameStateProtocol> { get }
    
    func execute(_ command: ActionProtocol)
}
