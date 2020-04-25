//
//  GameUpdate+ExecutionTime.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameUpdate {
    
    // GameUpdate relative execution time
    // Returns double between 0 and 1
    var executionTime: Double {
        switch self {
        case .playerPullFromDeck,
             .playerDiscardHand,
             .playerPutInPlay,
             .playerRevealHandCard,
             .playerDiscardInPlay,
             .playerPullFromOtherHand,
             .playerPullFromOtherInPlay,
             .playerPutInPlayOfOther,
             .playerPassInPlayOfOther,
             .playerPullFromGeneralStore,
             .flipOverFirstDeckCard:
            // Careful, after adding new animatable update,
            // you should thing about sequencing the executing move
            return 1
            
        default:
            return 0
        }
    }
}
