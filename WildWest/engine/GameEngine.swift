//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameEngine: GameEngineProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    private let suggestor: ActionSuggestorProtocol
    
    init(state: GameStateProtocol, suggestor: ActionSuggestorProtocol) {
        stateSubject = BehaviorSubject(value: state)
        self.suggestor = suggestor
    }
    
    func execute(_ action: ActionProtocol) {
        guard let state = try? stateSubject.value() else {
            return
        }
        
        action.execute(state: state)
        state.addCommand(action)
        
        let actions = suggestor.actions(matching: state)
        state.players.forEach { player in
            player.setActions(actions.filter { $0.actorId == player.identifier })
        }
        
        stateSubject.onNext(state)
    }
}
