//
//  GameViewModel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameViewModelProtocol {
    var stateSubject: BehaviorSubject<GameStateProtocol> { get }
    
    func execute(_ action: ActionProtocol)
}

class GameViewModel: GameViewModelProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    init(state: GameStateProtocol) {
        stateSubject = BehaviorSubject(value: state)
    }
    
    func execute(_ action: ActionProtocol) {
        guard let state = try? stateSubject.value() else {
            return
        }
        
        action.execute(state: state)
        stateSubject.onNext(state)
    }
}
