//
//  HomeViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? GameViewController,
            let engine = createGameEngine() else {
                return
        }
        
        viewController.engine = engine
    }
}

private extension HomeViewController {
    
    // swiftlint:disable function_body_length
    private func createGameEngine() -> GameEngineProtocol? {
        let provider = ResourcesProvider(jsonReader: JsonReader(bundle: Bundle.main))
        let figures = provider.allFigures()
        let cards = provider.allCards()
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: 7)
        let state = gameSetup.setupGame(roles: roles, figures: figures, cards: cards)
        guard let mutableState = state as? MutableGameStateProtocol else {
            return nil
        }
        
        let calculator = RangeCalculator()
        let rules: [RuleProtocol] = [
            BeerRule(),
            SaloonRule(),
            StagecoachRule(),
            WellsFargoRule(),
            EquipRule(),
            CatBalouRule(),
            PanicRule(calculator: calculator),
            BangRule(calculator: calculator),
            MissedRule(),
            GatlingRule(),
            IndiansRule(),
            JailRule(),
            DiscardBangRule(),
            DuelRule(),
            GeneralStoreRule(),
            ChooseCardRule(),
            LooseLifeRule(),
            StartTurnRule(),
            EndTurnRule(),
            ResolveJailRule(),
            ResolveDynamiteRule(),
            DiscardBeerRule(),
            ResolveBarrelRule()
        ]
        return GameEngine(state: state, mutableState: mutableState, rules: rules, calculator: OutcomeCalculator())
    }
}
