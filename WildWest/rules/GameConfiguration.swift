//
//  GameConfiguration.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameConfiguration {
    
    private let jsonReader: JsonReaderProtocol
    
    init(jsonReader: JsonReaderProtocol ) {
        self.jsonReader = jsonReader
    }
    
    var allCards: [CardProtocol] {
        jsonReader.load([Card].self, file: "cards")
    }
    
    var allFigures: [FigureProtocol] {
        jsonReader.load([Figure].self, file: "figures")
    }
    
    var moveMatchers: [MoveMatcherProtocol] {
        [
            // auto play
            StartGameMatcher(),
            StartTurnMatcher(),
            ExplodeDynamiteMatcher(),
            PassDynamiteMatcher(),
            EscapeFromJailMatcher(),
            StayInJailMatcher(),
            UseBarrelMatcher(),
            FailBarelMatcher(),
            
            // manual play
            BeerMatcher(),
            SaloonMatcher(),
            StagecoachMatcher(),
            WellsFargoMatcher(),
            PanicMatcher(calculator: RangeCalculator()),
            CatBalouMatcher(calculator: RangeCalculator()),
            EquipMatcher(),
            DynamiteMatcher(),
            JailMatcher(),
            GeneralStoreMatcher(),
            BangMatcher(calculator: RangeCalculator()),
            GatlingMatcher(),
            IndiansMatcher(),
            DuelMatcher(),
            EndTurnMatcher(),
            
            // manual reaction
            DiscardMissedMatcher(),
            DiscardBangOnDuelMatcher(),
            DiscardBangOnIndiansMatcher(),
            DiscardBeerMatcher(),
            PassMatcher(),
            ChooseCardMatcher(),
            
            // Effect
            EliminateMatcher(),
            GainRewardOnEliminatingOutlawMatcher(),
            PenalizeSheriffOnEliminatingDeputyMatcher()
        ]
    }
}
