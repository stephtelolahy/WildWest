//
//  GameConfiguration.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

// swiftlint:disable type_body_length
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
    
    var validMoveMatchers: [ValidMoveMatcherProtocol] {
        [EndTurnMatcher(),
         BeerMatcher(),
         SaloonMatcher(),
         StagecoachMatcher(),
         WellsFargoMatcher(),
         PanicMatcher(calculator: RangeCalculator()),
         CatBalouMatcher(calculator: RangeCalculator()),
         EquipMatcher(),
         JailMatcher(),
         DynamiteMatcher(),
         GeneralStoreMatcher(),
         ChooseGeneralStoreCardMatcher(),
         BangMatcher(calculator: RangeCalculator()),
         GatlingMatcher(),
         IndiansMatcher(),
         DuelMatcher(),
         DiscardMissedMatcher(),
         DiscardBangOnDuelMatcher(),
         DiscardBangOnIndiansMatcher(),
         DiscardBeerMatcher(),
         PassMatcher()]
    }
    
    var autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol] {
        [StartTurnMatcher(),
         ExplodeDynamiteMatcher(),
         PassDynamiteMatcher(),
         EscapeFromJailMatcher(),
         StayInJailMatcher(),
         UseBarrelMatcher(),
         FailBarelMatcher()]
    }
    
    var effectMatchers: [EffectMatcherProtocol] {
        [EliminateMatcher(),
         GainRewardOnEliminatingOutlawMatcher(),
         PenalizeSheriffOnEliminatingDeputyMatcher()]
    }
    
    var moveExectors: [MoveExecutorProtocol] {
        [EndTurnExecutor(),
         StartTurnExecutor(),
         BeerExecutor(),
         SaloonExecutor(),
         StagecoachExecutor(),
         WellsFargoExecutor(),
         PanicExecutor(),
         CatBalouExecutor(),
         EquipExecutor(),
         JailExecutor(),
         DynamiteExecutor(),
         ExplodeDynamiteExecutor(),
         PassDynamiteExecutor(),
         PassDynamiteExecutor(),
         EscapeFromJailExecutor(),
         StayInJailExecutor(),
         GeneralStoreExecutor(),
         ChooseGeneralStoreCardExecutor(),
         BangExecutor(),
         GatlingExecutor(),
         IndiansExecutor(),
         DuelExecutor(),
         DiscardMissedExecutor(),
         UseBarrelExecutor(),
         FailBarelExecutor(),
         DiscardBangOnDuelExecutor(),
         DiscardBangOnIndiansExecutor(),
         DiscardBeerExecutor(),
         PassExecutor(),
         EliminateExecutor(calculator: OutcomeCalculator()),
         GainRewardOnEliminatingOutlawExecutor(),
         PenalizeSheriffOnEliminatingDeputyExecutor()]
    }
}