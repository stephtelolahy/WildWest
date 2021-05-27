//
//  AbilityEvaluator.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 27/11/2020.
//

public protocol AbilityEvaluatorProtocol {
    func evaluate(_ move: GMove) -> Int
}

public class AbilityEvaluator: AbilityEvaluatorProtocol {
    
    public init() {
    }
    
    public func evaluate(_ move: GMove) -> Int {
        switch move.ability {
        case "endTurn",
             "looseHealth": 
            return  -1
            
        case "bang", 
             "duel",
             "punch",
             "springfield":
            return 3
            
        case "handicap",
             "discardOtherHand",
             "drawOtherHandAt1",
             "drawOtherHandRequire1Card",
             "startTurnDrawingPlayer":
            return 1
            
        case
            "discardAnyInPlay",
            "drawOtherInPlayAt1",
            "drawOtherInPlayRequire1Card":
            if let inPlayCard = move.args[.requiredInPlay]?.first, 
               inPlayCard.contains("jail") {
                return -1
            } else {
                return 1
            }
            
        case "tequila":
            return -1
            
        default:
            return 0
        }
    }
}
