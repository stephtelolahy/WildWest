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
    
    var validMoveMatchers: [ValidMoveMatcherProtocol] {
        [EndTurnMatcher(),
         BeerMatcher(),
         SaloonMatcher(),
         StagecoachMatcher(),
         WellsFargoMatcher(),
         PanicMatcher(calculator: RangeCalculator()),
         CatBalouMatcher(calculator: RangeCalculator()),
         EquipMatcher(),
         DynamiteMatcher(),
         GeneralStoreMatcher()]
    }
    
    var autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol] {
        [StartTurnMatcher(),
         ResolveDynamiteMatcher(),
         ResolveJailMatcher()]
    }
    
    var effectMatchers: [EffectMatcherProtocol] {
        []
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
         DynamiteExecutor(),
         ResolveDynamiteExecutor(),
         ResolveJailExecutor(),
         GeneralStoreExecutor()]
    }
    
    var updateExecutors: [UpdateExecutorProtocol] {
        [GameUpdateExecutor()]
    }
}
