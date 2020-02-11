//
//  MutableGameStateProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol MutableGameStateProtocol {
    func setTurn(_ turn: String)
    func setChallenge(_ challenge: Challenge?)
    func setBangsPlayed(_ bangsPlayed: Int)
    func addCommand(_ command: ActionProtocol)
    func setActions(_ actions: [ActionProtocol])
    func player(_ playerId: String, addHandCard card: CardProtocol)
    func pullDeck() -> CardProtocol
}
