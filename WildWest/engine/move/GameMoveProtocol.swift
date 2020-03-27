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

struct MoveName: RawRepresentable, Equatable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    var rawValue: String
}

extension MoveName {
    static let startTurn = MoveName("startTurn")    // phase1: start turn drawing 2 cards
    static let play = MoveName("play")              // phase2: play a hand card
    static let endTurn = MoveName("endTurn")        // phase3: end turn discarding excess cards
    static let choose = MoveName("choose")          // reaction move: choose one card from general store
    static let pass = MoveName("pass")              // reaction move: do nothing while attacked
}

struct TargetCard: Equatable {
    let ownerId: String
    let source: TargetCardSource
}

enum TargetCardSource: Equatable {
    case randomHand
    case inPlay(String)
}

/// Function matching state to moves
protocol MoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]?
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]?
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?
}

extension MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        nil
    }
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        nil
    }
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        nil
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        nil
    }
}
