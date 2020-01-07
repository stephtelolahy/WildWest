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
        
        let resources = GameResources(jsonReader: JsonReader(bundle: Bundle.main))
        let figures = resources.allFigures()
        let cards = resources.allCards()
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: 7)
        let state = gameSetup.setupGame(roles: roles, figures: figures, cards: cards)
        GameLoop().run(state: state)
    }
}
