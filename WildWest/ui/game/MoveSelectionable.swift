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
        
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .alert)
        
        actions.forEach { action in
            alertController.addAction(UIAlertAction(title: action.description,
                                                    style: .default,
                                                    handler: { _ in
                                                        completion(action)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
}
