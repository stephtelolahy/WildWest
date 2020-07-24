//
//  WaitingRoomViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class WaitingRoomViewController: UIViewController {
    
    var onQuit: (() -> Void)?
    
    @IBAction private func quitButtonTapped(_ sender: Any) {
        onQuit?()
    }
    
}
