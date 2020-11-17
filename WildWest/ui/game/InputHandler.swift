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
        let node = selector.select(active: moves)
        
        if let move = node.value {
            let alert = UIAlertController(title: context ?? node.name ?? "Play", 
                                          options: [context != nil ? node.name! : "OK"],
                                          cancelable: cancelable) { _ in
                completion(move)
            }
            viewController?.present(alert, animated: true)
            
        } else {
            
            let children = node.children!
            let options = children.map { $0.name! }
            let alert = UIAlertController(title: context ?? node.name ?? "Play", 
                                          options: options,
                                          cancelable: cancelable) { index in
                let child = children[index]
                if let childMove = child.value {
                    completion(childMove)
                } else {
                    #warning("TODO: open alert to choose sub-options")
                    fatalError("Unsupported")
                }
            }
            viewController?.present(alert, animated: true)
        }
    }
}
