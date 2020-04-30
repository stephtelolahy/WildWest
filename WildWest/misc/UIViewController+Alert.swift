//
//  UIViewController+Alert.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func forcePresent(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        guard presentedViewController == nil else {
            self.dismiss(animated: false) {
                self.present(viewControllerToPresent, animated: flag)
            }
            return
        }
        
        present(viewControllerToPresent, animated: flag)
    }
    
    func select(title: String, choices: [String], cancelable: Bool = true, completion: @escaping((Int) -> Void)) {
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
        
        if cancelable {
            alertController.addAction(UIAlertAction(title: "Cancel",
                                                    style: .cancel,
                                                    handler: nil))
        }
        
        present(alertController, animated: true)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        forcePresent(alertController, animated: true)
    }
}
