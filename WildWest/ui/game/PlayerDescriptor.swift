//
//  PlayerDescriptor.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol PlayerDescriptorProtocol {
    func display(_ player: PlayerProtocol)
}

class PlayerDescriptor: PlayerDescriptorProtocol {
    
    private unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func display(_ player: PlayerProtocol) {
        let alertController = UIAlertController(title: player.figureName.rawValue.uppercased(),
                                                message: player.description,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Close",
                                                style: .cancel,
                                                handler: nil))
        
        viewController.present(alertController, animated: true)
    }
    
}
