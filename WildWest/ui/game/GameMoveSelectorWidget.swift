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
    
    func selectMove(among moves: [GMove], context: String?, cancelable: Bool, completion: @escaping (GMove) -> Void) {
        var root = selector.select(moves)
        
        if let context = context {
            switch root.value {
            case let .options(nodes):
                root = MoveNode(name: context, value: .options(nodes))
                
            case let .move(move):
                root = MoveNode(name: context, value: .options([MoveNode(name: move.ability, value: .move(move))]))
            }
        }
        
        select(root, cancelable: cancelable, completion: completion)
    }
}

private extension GameMoveSelectorWidget {
    
    func select(_ node: MoveNode, cancelable: Bool, completion: @escaping (GMove) -> Void) {
        switch node.value {
        case let .move(move):
            completion(move)
            
        case let .options(children):
            let alert = UIAlertController(title: node.name,
                                          options: children.map { $0.name },
                                          cancelable: cancelable) { [weak self] index in
                self?.select(children[index], cancelable: cancelable, completion: completion)
            }
            viewController?.present(alert, animated: true)
        }
    }
}
