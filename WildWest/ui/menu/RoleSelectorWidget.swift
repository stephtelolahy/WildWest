//
//  RoleSelectorWidget.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine
import ImageSlideshow

class RoleSelectorWidget: FullScreenSlideshowViewController {
    
    convenience init(initialRole: Role?,
                     completion: @escaping (Role?) -> Void) {
        self.init()
        modalTransitionStyle = .crossDissolve
        
        let roles = Role.allCases
        let imageNames = ["01_back"] + roles.map { "01_\($0.rawValue.lowercased())" }
        let images = imageNames.map { BundleImageSource(imageString: $0) }
        let initialIndex: Int
        if let initialRole = initialRole,
           let index = roles.firstIndex(of: initialRole) {
            initialIndex = index + 1
        } else {
            initialIndex = 0
        }
        
        inputs = images
        initialPage = initialIndex
        
        pageSelected = { page in
            
            let selectedRole: Role?
            if page == 0 {
                selectedRole = nil
            } else {
                selectedRole = roles[page - 1]
            }
            
            completion(selectedRole)
        }
    }
}
