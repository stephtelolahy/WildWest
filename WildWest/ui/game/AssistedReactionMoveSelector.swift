//
//  AssistedReactionMoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 12/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class AssistedReactionMoveSelector: ReactionMoveSelectorProtocol {
    
    private let ai: AIProtocol
    
    init(ai: AIProtocol) {
        self.ai = ai
    }
    
    func selectMove(within moves: [GameMove], state: GameStateProtocol, completion: @escaping (GameMove) -> Void) {
        guard let move = ai.bestMove(among: moves, in: state) else {
            return
        }
        
        completion(move)
    }
}
