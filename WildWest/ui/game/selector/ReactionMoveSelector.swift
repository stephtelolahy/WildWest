//
//  ReactionMoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol ReactionMoveSelectorProtocol {
    func selectMove(within moves: [GameMove], state: GameStateProtocol, completion: @escaping (GameMove) -> Void)
}

class ReactionMoveSelector: ReactionMoveSelectorProtocol {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func selectMove(within moves: [GameMove], state: GameStateProtocol, completion: @escaping (GameMove) -> Void) {
        guard let challenge = state.challenge else {
            fatalError("Illegal state")
        }
        
        let choices: [String] = moves.map {
            $0.cardId ?? $0.targetCard?.description ?? $0.discardIds?.joined(separator: ", ") ??  $0.name.rawValue
        }
        viewController.select(title: challenge.description(in: state),
                              message: challenge.message(in: state),
                              choices: choices,
                              cancelable: false) { index in
                                completion(moves[index])
        }
    }
}

private extension Challenge {
    
    func description(in state: GameStateProtocol) -> String {
        switch name {
        case .dynamiteExploded:
            return "dynamite exploded (-\(damage))"
            
        case .duel:
            return "duel by \(state.turn)"
            
        case .bang:
            return "bang by \(state.turn)"
            
        case .gatling:
            return "gatling by \(state.turn)"
            
        case .indians:
            return "indians by \(state.turn)"
            
        case .generalStore:
            return "general store by \(state.turn)"
            
        default:
            return name.rawValue
        }
    }
    
    func message(in state: GameStateProtocol) -> String? {
        switch name {
        case .startTurn:
            return state.player(state.turn)?.description
            
        default:
            return nil
        }
    }
}
