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
        [StartGameMatcher(),
         StartTurnMatcher(),
         ExplodeDynamiteMatcher(),
         PassDynamiteMatcher(),
         EscapeFromJailMatcher(),
         StayInJailMatcher(),
        ]
        /*
        [EndTurnMatcher(),
         StartTurnMatcher(),
         BeerMatcher(),
         SaloonMatcher(),
         StagecoachMatcher(),
         WellsFargoMatcher(),
         PanicMatcher(),
         CatBalouMatcher(),
         EquipMatcher(),
         JailMatcher(),
         DynamiteMatcher(),
         
         PassDynamiteMatcher(),
         
         GeneralStoreMatcher(),
         ChooseGeneralStoreCardMatcher(),
         BangMatcher(),
         GatlingMatcher(),
         IndiansMatcher(),
         DuelMatcher(),
         DiscardMissedMatcher(),
         UseBarrelMatcher(),
         FailBarelMatcher(),
         DiscardBangOnDuelMatcher(),
         DiscardBangOnIndiansMatcher(),
         DiscardBeerMatcher(),
         PassMatcher(),
         EliminateExecutor(calculator: OutcomeCalculator()),
         GainRewardOnEliminatingOutlawMatcher(),
         PenalizeSheriffOnEliminatingDeputyMatcher()]
         */
    }
}
