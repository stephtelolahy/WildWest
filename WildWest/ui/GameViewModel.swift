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
        
        // TODO: generate possible actions if needed
        
        stateSubject.onNext(state)
    }
}

class GameAI {
    func generateActions(from state: GameStateProtocol) -> [ActionProtocol] {
        return ([
            Beer.match(state: state),
            Saloon.match(state: state),
            Stagecoach.match(state: state),
            WellsFargo.match(state: state),
            Equip.match(state: state),
            Jail.match(state: state),
            Shoot.match(state: state),
            Missed.match(state: state),
            Gatling.match(state: state),
            Indians.match(state: state),
            Duel.match(state: state),
            Panic.match(state: state),
            CatBalou.match(state: state),
            GeneralStore.match(state: state),
            EndTurn.match(state: state),
            BeerLastLifePoint.match(state: state)
        ] as [[ActionProtocol]])
            .flatMap { $0 }
    }
}
