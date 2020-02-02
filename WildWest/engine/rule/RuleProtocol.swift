//
//  RuleProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol RuleProtocol {
    var actionName: String { get }
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]
}

struct GenericAction {
    let name: String
    let options: [ActionProtocol]
}

extension RuleProtocol {
    func matchGeneric(with state: GameStateProtocol) -> GenericAction? {
        let options = match(with: state)
        guard !options.isEmpty else {
            return nil
        }
        
        return GenericAction(name: actionName, options: options)
    }
}
