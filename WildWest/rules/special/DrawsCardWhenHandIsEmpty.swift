//
//  DrawsCardWhenHandIsEmpty.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DrawsCardWhenHandIsEmptyMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
        guard let actor = state.players.first(where: {
            $0.hand.isEmpty && $0.abilities[.drawsCardWhenHandIsEmpty] == true }) else {
            return nil
        }
        
        return GameMove(name: .drawsCardWhenHandIsEmpty, actorId: actor.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .drawsCardWhenHandIsEmpty = move.name else {
            return nil
        }
        
        return [.playerPullFromDeck(move.actorId)]
    }
}

extension MoveName {
    static let drawsCardWhenHandIsEmpty = MoveName("drawsCardWhenHandIsEmpty")
}
