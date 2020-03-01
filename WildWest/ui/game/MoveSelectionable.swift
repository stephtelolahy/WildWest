//
//  MoveSelectionable.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol MoveSelectionable {
    func selectMove(within actions: [ActionProtocol], completion: @escaping ((ActionProtocol) -> Void))
}

extension MoveSelectionable where Self: UIViewController {
    
    func selectMove(within actions: [ActionProtocol], completion: @escaping ((ActionProtocol) -> Void)) {
        guard !actions.isEmpty else {
            return
        }
        
        if actions.count == 1 {
            completion(actions[0])
            return
        }
        
        if let playCardAgainstOnePlayerActions = actions as? [PlayCardAgainstOnePlayerActionProtocol] {
            selectPlayer(within: playCardAgainstOnePlayerActions, completion: completion)
            return
        }
        
        assert(false, "unsupported")
    }
    
    private func selectPlayer(within actions: [PlayCardAgainstOnePlayerActionProtocol],
                              completion: @escaping ((ActionProtocol) -> Void)) {
        let targetIds = actions.map { $0.targetId }
        select(within: targetIds, title: "Select player") { index in
            completion(actions[index])
        }
    }
}

private extension UIViewController {
    func select(within choices: [String], title: String, completion: @escaping((Int) -> Void)) {
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
