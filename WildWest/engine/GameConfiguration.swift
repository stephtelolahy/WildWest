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
        [BeerMatcher(),
         SaloonMatcher(),
         StagecoachMatcher(),
         WellsFargoMatcher(),
         PanicMatcher(calculator: RangeCalculator())]
    }
    
    var autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol] {
        [StartTurnMatcher()]
    }
    
    var effectMatchers: [EffectMatcherProtocol] {
        []
    }
    
    var moveExectors: [MoveExecutorProtocol] {
        [StartTurnExecutor(),
         BeerExecutor(),
         SaloonExecutor(),
         StagecoachExecutor(),
         WellsFargoExecutor(),
         PanicExecutor()]
    }
    
    var updateExecutors: [UpdateExecutorProtocol] {
        [GameUpdateExecutor()]
    }
}
