//
//  InputHandler.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 17/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

protocol InputHandlerProtocol {
    func selectMove(among moves: [GMove], context: String?, cancelable: Bool, completion: @escaping (GMove) -> Void)
}

class InputHandler: InputHandlerProtocol {
    
    private let selector: MoveSelectorProtocol
    private let router: RouterProtocol
    
    init(selector: MoveSelectorProtocol, router: RouterProtocol) {
        self.selector = selector
        self.router = router
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

private extension InputHandler {
    
    func select(_ node: MoveNode, cancelable: Bool, completion: @escaping (GMove) -> Void) {
        switch node.value {
        case let .move(move):
            completion(move)
            
        case let .options(children):
            router.toGameMoveSelector(node.name, children: children, cancelable: cancelable) { [weak self] node in
                self?.select(node, cancelable: cancelable, completion: completion)
            }
        }
    }
}
