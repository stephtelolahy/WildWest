//
//  UIStoryboardExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

/// Instantiate a specific UIViewController type from storyboard
///
extension UIStoryboard {
    static func instantiate<T: UIViewController>(_ type: T.Type,
                                                 in storyboardName: String? = nil,
                                                 storyboardId: String? = nil) -> T {
        let storyboardName: String = storyboardName ?? T.className.deletingSuffix("ViewController")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        }

        let storyboardId: String = storyboardId ?? T.className
        if let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T {
            return viewController
        }

        fatalError("Could not instantiate \(T.className) identified by \(storyboardId) in \(storyboardName)")
    }
}

private extension String {
    func deletingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else {
            return self
        }

        return String(dropLast(suffix.count))
    }
}
