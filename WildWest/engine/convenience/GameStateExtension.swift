//
//  GameStateExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func discardableCards(from actor: PlayerProtocol, and otherPlayers: [PlayerProtocol]) -> [DiscardableCard]? {
        var result: [DiscardableCard] = []
        result += actor.inPlay.map { DiscardableCard(cardId: $0.identifier,
                                                     ownerId: actor.identifier,
                                                     source: .inPlay)
        }
        
        for player in otherPlayers {
            result += player.hand.map { DiscardableCard(cardId: $0.identifier,
                                                        ownerId: player.identifier,
                                                        source: .hand)
                
            }
            
            result += player.inPlay.map { DiscardableCard(cardId: $0.identifier,
                                                          ownerId: player.identifier,
                                                          source: .inPlay)
            }
        }
        
        guard !result.isEmpty else {
            return nil
        }
        
        return result
    }
}
