//
//  GameMoveSelectorWidget.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 02/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class GameMoveSelectorWidget {
    
    private let selector: MoveSelectorProtocol
    private weak var viewController: UIViewController?
    
    init(selector: MoveSelectorProtocol, viewController: UIViewController) {
        self.selector = selector
        self.viewController = viewController
    }
    
    func selectMove(among moves: [GMove], title: String?, cancelable: Bool, completion: @escaping (GMove) -> Void) {
        let root = selector.select(moves, suggestedTitle: title)
        select(root, cancelable: cancelable, completion: completion)
    }
}

private extension GameMoveSelectorWidget {
    
    func select(_ node: Node<GMove>, cancelable: Bool, completion: @escaping (GMove) -> Void) {
        
        if let move = node.value {
            completion(move)
            return
        }
        
        if let children = node.children {
            let alert = UIAlertController(title: node.title,
                                          options: children.map { $0.title },
                                          cancelable: cancelable) { [weak self] index in
                self?.select(children[index], cancelable: cancelable, completion: completion)
            }
            viewController?.present(alert, animated: true)
        }
    }
}
