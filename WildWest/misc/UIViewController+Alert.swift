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
}
