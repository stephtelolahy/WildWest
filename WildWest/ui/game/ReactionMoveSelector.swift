//
//  ReactionMoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol ReactionMoveSelectorProtocol {
    func selectMove(within moves: [GameMove], challenge: Challenge, completion: @escaping (GameMove) -> Void)
}

class ReactionMoveSelector: ReactionMoveSelectorProtocol {
    
    private unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func selectMove(within moves: [GameMove], challenge: Challenge, completion: @escaping (GameMove) -> Void) {
        
        switch challenge.name {
        case .generalStore, .discardExcessCards:
            let cardIds = moves.compactMap { $0.cardId }
            viewController.selectWithoutCancel(title: challenge.description, choices: cardIds) { index in
                completion(moves[index])
            }
            
        default:
            let choices = moves.map { [$0.name.rawValue, $0.cardId].compactMap { $0 }.joined(separator: " ") }
            viewController.selectWithoutCancel(title: challenge.description, choices: choices) { index in
                completion(moves[index])
            }
        }
    }
}

private extension UIViewController {
    func selectWithoutCancel(title: String, choices: [String], completion: @escaping((Int) -> Void)) {
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        
        choices.forEach { choice in
            alertController.addAction(UIAlertAction(title: choice,
                                                    style: .default,
                                                    handler: { _ in
                                                        guard let index = choices.firstIndex(of: choice) else {
                                                            return
                                                        }
                                                        completion(index)
            }))
        }
        
        present(alertController, animated: true)
    }
}
