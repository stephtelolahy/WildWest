//
//  UIAlertControllerExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 08/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    convenience init(title: String,
                     choices: [String],
                     cancelable: Bool = true,
                     completion: @escaping((Int) -> Void)) {
        self.init(title: title, message: nil, preferredStyle: .alert)
        
        for (index, choice) in choices.enumerated() {
            addAction(UIAlertAction(title: choice,
                                    style: .default,
                                    handler: { _ in
                                        completion(index)
                                    }))
        }
        
        if cancelable {
            addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
    }
    
    convenience init(title: String, message: String, closeAction: String, completion: (() -> Void)? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        addAction(UIAlertAction(title: closeAction, style: .cancel, handler: { _ in
            completion?()
        }))
    }
}

