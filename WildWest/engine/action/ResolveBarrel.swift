//
//  ResolveBarrel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ResolveBarrel: ActionProtocol, Equatable {
    let actorId: String
    
    func execute(in state: GameStateProtocol) {
        
    }
    
    var description: String {
        return ""
    }
}

struct ResolveBarrelRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        nil
    }
}
