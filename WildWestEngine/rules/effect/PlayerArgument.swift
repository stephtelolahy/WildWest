//
//  PlayerArgument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum PlayerArgument: String, Decodable {
    case actor
    case target
    case all
    case next
    case others
    case nobody
    case othersWithCard
}

extension PlayContext {
    
    func players(matching arg: PlayerArgument) -> [String] {
        switch arg {
        case .actor:
            return [actor.identifier]
            
        case .target:
            let target = args[.target]!.first!
            return [target]
            
        case .all:
            return state.playOrder
                .starting(with: actor.identifier)
            
        case .others:
            let all = state.playOrder
                .starting(with: actor.identifier)
            return Array(all.dropFirst())
            
        case .next:
            let playing = state.playOrder
            if playing.contains(actor.identifier) {
                let next = playing.starting(with: actor.identifier)[1]
                return [next]
            }
            
            let nexts = state.initialOrder
                .starting(with: actor.identifier)
                .dropFirst()
            guard let next = nexts.first(where: { playing.contains($0) }) else {
                fatalError("No next player found after \(actor.identifier)")
            }
            return [next]
            
        case .nobody:
            return []
            
        case .othersWithCard:
            let all = state.playOrder
                .starting(with: actor.identifier)
            let others = Array(all.dropFirst())
            return others.filter { !state.players[$0]!.hand.isEmpty || !state.players[$0]!.inPlay.isEmpty }
        }
    }
}
