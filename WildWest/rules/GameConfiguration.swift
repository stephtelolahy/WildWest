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
        jsonReader.load([FigureDto].self, file: "figures")
            .map { FigureMapper().map(dto: $0) }
    }
    
    var moveMatchers: [MoveMatcherProtocol] {
        [
            // auto play
            StartTurnMatcher(),
            ExplodeDynamiteMatcher(),
            PassDynamiteMatcher(),
            ResolveJailMatcher(),
            ResolveBarrelMatcher(),
            
            // manual play
            BeerMatcher(),
            SaloonMatcher(),
            StagecoachMatcher(),
            WellsFargoMatcher(),
            PanicMatcher(),
            CatBalouMatcher(),
            EquipMatcher(),
            DynamiteMatcher(),
            JailMatcher(),
            GeneralStoreMatcher(),
            BangMatcher(),
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
            DiscardExcessCardMatcher(),
            
            // Effect
            EliminateMatcher(),
            GainRewardOnEliminatingOutlawMatcher(),
            PenalizeSheriffOnEliminatingDeputyMatcher(),
            
            // Special
            DrawsCardOnLoseHealthMatcher(),
            DrawsCardFromPlayerDamagedHimMatcher(),
            DrawsCardWhenHandIsEmptyMatcher()
        ]
    }
}
