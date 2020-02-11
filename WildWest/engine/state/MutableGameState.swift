//
//  MutableGameState.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameState: MutableGameStateProtocol {
    
    func setTurn(_ turn: String) {
        self.turn = turn
    }
    
    func setChallenge(_ challenge: Challenge?) {
        self.challenge = challenge
    }
    
    func setBangsPlayed(_ bangsPlayed: Int) {
        self.bangsPlayed = bangsPlayed
    }
    
    func addCommand(_ command: ActionProtocol) {
        commands.append(command)
    }
    
    func setActions(_ actions: [ActionProtocol]) {
        self.actions = actions
    }
    
    func player(_ playerId: String, addHandCard card: CardProtocol) {
        (players.first(where: { $0.identifier == playerId }) as? Player)?.hand.append(card)
    }
    
    func pullDeck() -> CardProtocol {
        deck.removeFirst()
    }
}
