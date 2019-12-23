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
        let state = GameState(players: [],
                              deck: CardList(cards: []),
                              discard: CardList(cards: []))
        GameLoop().run(state: state)
    }
}
