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
        
        if moves.contains(where: { $0.targetId != nil }) {
            let targetIds = moves.compactMap { $0.targetId }
            viewController.select(title: "Select player", choices: targetIds) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.contains(where: { $0.targetCard != nil }) {
            let targets = moves.compactMap { $0.targetCard?.description }
            viewController.select(title: "Select target card", choices: targets) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.contains(where: { $0.discardIds != nil }) {
            let cardsCombinations = moves.compactMap { $0.discardIds?.joined(separator: ", ") }
            viewController.select(title: "Select cards", choices: cardsCombinations) { index in
                completion(moves[index])
            }
            return
        }
        
        if let firstMove = moves.first {
            completion(firstMove)
            return
        }
    }
}

private extension UIViewController {
    
    func select(title: String, choices: [String], completion: @escaping((Int) -> Void)) {
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
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
}
