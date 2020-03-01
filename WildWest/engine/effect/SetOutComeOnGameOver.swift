//
//  SetOutComeOnGameOver.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct SetOutComeOnGameOverRule: EffectRuleProtocol {
    
    let calculator: OutcomeCalculatorProtocol
    
    func effectOnExecuting(action: ActionProtocol, in state: GameStateProtocol) -> ActionProtocol? {
        guard action is Eliminate,
            let outcome = calculator.outcome(for: state.players.map { $0.role }) else {
                return nil
        }
        
        let description = "game is over: \(outcome)"
        let updates: [GameUpdate] = [.setOutcome(outcome)]
        
        return Action(actorId: "",
                      cardId: "",
                      autoPlay: true,
                      description: description,
                      updates: updates)
    }
}
