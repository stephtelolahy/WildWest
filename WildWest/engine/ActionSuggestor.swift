//
//  ActionSuggestor.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ActionSuggestor: ActionSuggestorProtocol {
    
    private let rules: [RuleProtocol] = [
        BeerRule(),
        SaloonRule(),
        StagecoachRule(),
        WellsFargoRule(),
        EquipRule(),
        CatBalouRule(),
        PanicRule(rangeCalculator: RangeCalculator()),
        StartTurnRule(),
        EndTurnRule()
    ]
    
    func actions(matching state: GameStateProtocol) -> [ActionProtocol] {
        return rules.map { $0.match(state: state) }.flatMap { $0 }
    }
}
