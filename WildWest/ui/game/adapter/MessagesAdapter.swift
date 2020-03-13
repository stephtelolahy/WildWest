//
//  MessagesAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol MessagesAdapterProtocol {
    var actions: [ActionProtocol] { get }
    var title: String? { get }
    
    func setState(_ state: GameStateProtocol)
    func setControlledPlayerId(_ identifier: String?)
}

class MessagesAdapter: MessagesAdapterProtocol {
    
    var actions: [ActionProtocol] = []
    var title: String?
    private var controlledPlayerId: String?
    
    func setState(_ state: GameStateProtocol) {
        actions = state.moves
        title = titleText(for: state)
    }
    
    func setControlledPlayerId(_ identifier: String?) {
        self.controlledPlayerId = identifier
    }
    
    private func titleText(for state: GameStateProtocol) -> String {
        if let outcome = state.outcome {
            return outcome.rawValue
        }
        
        if let challenge = state.challenge {
            return challenge.description
        }
        
        if state.validMoves.contains(where: { $0.actorId == controlledPlayerId }) {
            return "your turn"
        }
        
        return "waiting others to play"
    }
}
