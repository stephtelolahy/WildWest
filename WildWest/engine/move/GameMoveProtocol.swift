//
//  GameMoveProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// A concrete action performed by a player or the game itself
struct GameMove: Equatable {
    let name: MoveName                  // move type
    var actorId: String?                // identifier of player performing move
    var cardId: String?                 // identifier of played/chosen card
    var cardName: CardName?             // name of played card
    var targetId: String?               // identifier of targeted player
    var targetCard: TargetCard?         // identifier of targeted card
    var discardIds: [String]?           // identifiers of discarded hand cards
}

enum MoveName: String {
    // player moves
    case startTurn  // phase1: start turn drawing 2 cards
    case play       // phase2: play a hand card
    case endTurn    // phase3: end turn discarding excess cards
    case choose     // reaction move: choose one card from general store
    case discard    // reaction move: discard card to cancel an attack
    case pass       // reaction move: do nothing while attacked
    
    // autoPlay
    case escapeFromJail
    case stayInJail
    case explodeDynamite
    case passDynamite
    case useBarrel
    case failBarrel
    
    // effects
    case eliminate
    case gainRewardOnEliminatingOutlaw
    case penalizeSheriffOnEliminatingDeputy
}

struct TargetCard: Equatable {
    let ownerId: String
    let source: TargetCardSource
}

enum TargetCardSource: Equatable {
    case randomHand
    case inPlay(String)
}

/// Function defining manual player move regarding given state
protocol ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]?
}

/// Function defining automatic player move regarding given state
protocol AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]?
}

/// Function defining effect after playing given move
protocol EffectMatcherProtocol {
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?
}

/// Function defining game updates on executing move
protocol MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?
}
