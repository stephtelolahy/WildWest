//
//  GameLoader.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameLoader {
    
    func createGame(for playersCount: Int, provider: ResourcesProviderProtocol) -> GameDatabaseProtocol {
        let figures = provider.allFigures()
        let cards = provider.allCards()
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: playersCount)
        let state = gameSetup.setupGame(roles: roles.shuffled(),
                                        figures: figures.shuffled(),
                                        cards: cards.shuffled())
        guard let database = state as? GameDatabaseProtocol else {
            fatalError("Invalid database")
        }
        
        return database
    }
    
    func classicRules() -> [RuleProtocol] {
        [
            EliminateRule(),
            ResolveDynamiteRule(),
            ResolveJailRule(),
            StartTurnRule(),
            UseBarrelRule(),
            
            MissedRule(),
            DiscardBangRule(),
            DiscardBeerRule(),
            ChooseCardRule(),
            LooseLifeRule(),
            
            BeerRule(),
            SaloonRule(),
            StagecoachRule(),
            WellsFargoRule(),
            EquipRule(),
            CatBalouRule(),
            PanicRule(calculator: RangeCalculator()),
            BangRule(calculator: RangeCalculator()),
            GatlingRule(),
            IndiansRule(),
            DuelRule(),
            JailRule(),
            GeneralStoreRule(),
            EndTurnRule()
        ]
    }
    
    func effectRules() -> [EffectRuleProtocol] {
        [
            SetOutComeOnGameOverRule(calculator: OutcomeCalculator()),
            RewardOneWhoEliminatesOutlawRule(),
            DiscardAllSheriffCardsOnEliminateDeputy()
        ]
    }
}
