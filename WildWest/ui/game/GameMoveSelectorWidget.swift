//
//  GameMoveSelectorWidget.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 02/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class GameMoveSelectorWidget: UIAlertController {
    
    convenience init(_ title: String, children: [MoveNode], cancelable: Bool, completion: @escaping (MoveNode) -> Void) {
        self.init(title: title,
                  options: children.map { $0.name },
                  cancelable: cancelable) { index in
            completion(children[index])
        }
    }
}
