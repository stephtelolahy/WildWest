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
        
        let choices: [String] = moves.map { $0.cardId ?? $0.name.rawValue }
        viewController.select(title: challenge.description(in: state), choices: choices, cancelable: false) { index in
            completion(moves[index])
        }
    }
}
