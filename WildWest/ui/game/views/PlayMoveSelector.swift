//
//  PlayMoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol PlayMoveSelectorProtocol {
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void)
}

class PlayMoveSelector: PlayMoveSelectorProtocol {
    
    private unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        guard !moves.isEmpty else {
            return
        }
        
        if moves.allSatisfy({ $0.targetId != nil }) {
            let targetIds = moves.compactMap { $0.targetId }
            viewController.select(title: "Select player", choices: targetIds) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.allSatisfy({ $0.targetCard != nil }) {
            let targets = moves.compactMap { $0.targetCard?.description }
            viewController.select(title: "Select target card", choices: targets) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.count == 1 {
            completion(moves[0])
            return
        }
        
        // TODO: select multiple moves
        fatalError("Illegal state")
    }
}
