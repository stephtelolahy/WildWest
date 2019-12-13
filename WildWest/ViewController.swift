//
//  ViewController.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/9/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = Game(players: [], deck: [], discard: [])
        GameEngine(state: SimpleGameState(game), rules: BangRules(), aiPlayer: BasicAI(), renderer: ConsoleRenderer())
            .run()
    }
}
