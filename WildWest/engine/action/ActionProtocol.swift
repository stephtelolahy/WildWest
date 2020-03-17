//
//  ActionProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol ActionProtocol {
    var actorId: String { get }
    var description: String { get }
    var autoPlay: Bool { get }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol]
}

protocol PlayCardAtionProtocol: ActionProtocol {
    var cardId: String { get }
}

protocol PlayCardAgainstOnePlayerActionProtocol: PlayCardAtionProtocol {
    var targetId: String { get }
}

protocol PlayCardAgainstOneCardActionProtocol: PlayCardAtionProtocol {
    var target: TargetCard { get }
}

protocol ChooseCardActionProtocol: ActionProtocol {
    var cardId: String { get }
}

protocol ChooseCardsCombinationActionProtocol: ActionProtocol {
    var cardIds: [String] { get }
}

struct Action: ActionProtocol {
    let actorId: String
    let autoPlay: Bool
    let description: String
    let updates: [GameUpdateProtocol]
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        updates
    }
}
