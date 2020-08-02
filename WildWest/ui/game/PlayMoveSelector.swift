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
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        guard !moves.isEmpty else {
            return
        }
        
        if moves.count == 1,
            let uniqueMove = moves.first,
            uniqueMove.targetId == nil,
            uniqueMove.targetCard == nil,
            uniqueMove.discardIds == nil {
            completion(uniqueMove)
            return
        }
        
        if moves.allSatisfy({ $0.name == moves[0].name && $0.cardId == moves[0].cardId }) {
            let choices: [String] = moves.map {
                [$0.targetId,
                 $0.targetCard?.description,
                 $0.discardIds?.joined(separator: ", ")]
                    .compactMap { $0 }
                    .joined(separator: " ")
            }
            viewController.select(title: moves[0].name.rawValue, choices: choices) { index in
                completion(moves[index])
            }
            return
        }
        
        let choices: [String] = moves.map {
            [$0.name.rawValue,
             $0.cardId,
             $0.targetId,
             $0.targetCard?.description,
             $0.discardIds?.joined(separator: ", ")]
                .compactMap { $0 }
                .joined(separator: " ")
        }
        viewController.select(title: "Select move", choices: choices) { index in
            completion(moves[index])
        }
    }
}
