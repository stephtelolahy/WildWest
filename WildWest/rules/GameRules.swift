//
//  GameRules.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameRules {
    
    var moveMatchers: [MoveMatcherProtocol] {
        [
            // auto play
            StartTurnMatcher(),
            ResolveDynamiteMatcher(),
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
            
            // Effect
            EliminateMatcher(),
            GainRewardOnEliminatingOutlawMatcher(),
            PenalizeSheriffOnEliminatingDeputyMatcher(),
            
            // Special
            DrawsCardOnLoseHealthMatcher(),
            DrawsCardFromPlayerDamagedHimMatcher(),
            DrawsCardWhenHandIsEmptyMatcher(),
            Discard2CardsFor1LifeMatcher()
        ]
    }
}
