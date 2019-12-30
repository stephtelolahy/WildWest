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
        
        let resourcesManager = ResourcesManager(jsonReader: JsonReader(bundle: Bundle.main))
        let cards = resourcesManager.allCards()
        let state = GameSetup().setupGame(playersCount: 7, cards: cards)
        GameLoop().run(state: state)
    }
}
