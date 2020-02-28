//
//  GameUpdateFlipOverFirstDeckCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdateFlipOverFirstDeckCard: GameUpdateProtocol {
    
    var description: String {
        "flipOverFirstDeckCard"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        let card = database.deckRemoveFirst()
        database.addDiscard(card)
        database.setBarrelsResolved(database.state.barrelsResolved + 1)
    }
}
