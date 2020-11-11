//
//  DtoEncoder+Move.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
/*
import Foundation

extension DtoEncoder {
    
    func encode(move: GameMove) -> GameMoveDto {
        GameMoveDto(name: move.name.rawValue,
                    actorId: move.actorId,
                    cardId: move.cardId,
                    targetId: move.targetId,
                    targetCard: encode(targetCard: move.targetCard),
                    discardIds: move.discardIds)
    }
    
    func decode(move: GameMoveDto) throws -> GameMove {
        GameMove(name: MoveName(try move.name.unwrap()),
                 actorId: try move.actorId.unwrap(),
                 cardId: move.cardId,
                 targetId: move.targetId,
                 targetCard: try decode(targetCard: move.targetCard),
                 discardIds: move.discardIds)
    }
}

private extension DtoEncoder {
    
    func encode(targetCard: TargetCard?) -> TargetCardDto? {
        guard let targetCard = targetCard else {
            return nil
        }
        
        return TargetCardDto(ownerId: targetCard.ownerId,
                             source: encode(targetCardSource: targetCard.source))
    }
    
    func encode(targetCardSource: TargetCardSource) -> TargetCardSourceDto {
        switch targetCardSource {
        case .randomHand:
            return TargetCardSourceDto(randomHand: true)
            
        case let .inPlay(cardId):
            return TargetCardSourceDto(inPlay: cardId)
        }
    }
    
    func decode(targetCard: TargetCardDto?) throws -> TargetCard? {
        guard let targetCard = targetCard else {
            return nil
        }
        
        return TargetCard(ownerId: try targetCard.ownerId.unwrap(),
                          source: try decode(targetCardSource: try targetCard.source.unwrap()))
    }
    
    func decode(targetCardSource: TargetCardSourceDto) throws -> TargetCardSource {
        if targetCardSource.randomHand == true {
            return .randomHand
        }
        
        if let cardId = targetCardSource.inPlay {
            return .inPlay(cardId)
        }
        
        throw NSError(domain: "invalid TargetCardSourceDto", code: 0)
    }
}
*/
