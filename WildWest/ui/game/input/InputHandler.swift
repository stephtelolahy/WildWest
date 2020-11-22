//
//  InputHandler.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 17/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

protocol InputHandlerProtocol {
    func selectMove(among moves: [GMove], context: String?, cancelable: Bool, completion: @escaping (GMove) -> Void)
}

class InputHandler: InputHandlerProtocol {
    
    private let selector: MoveSelectorProtocol
    private weak var viewController: UIViewController?
    
    init(selector: MoveSelectorProtocol, viewController: UIViewController) {
        self.selector = selector
        self.viewController = viewController
    }
    
    func selectMove(among moves: [GMove], context: String?, cancelable: Bool, completion: @escaping (GMove) -> Void) {
        var root = selector.select(active: moves)
        
        if let context = context {
            switch root.value {
            case let .options(nodes):
                root = MoveNode(name: context, value: .options(nodes))
                
            case let .move(move):
                root = MoveNode(name: context, value: .options([MoveNode(name: move.name, value: .move(move))]))
            }
        }
        
        select(root, cancelable: cancelable, completion: completion)
    }
}

private extension InputHandler {
    
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
