//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StartTurnMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            !actor.inPlay.contains(where: { $0.name == .jail }),
            !actor.inPlay.contains(where: { $0.name == .dynamite }) else {
                return nil
        }
        
        if actor.abilities[.onStartTurnDrawsAnotherCardIfRedSuit] == true {
            return GameMove(name: .startTurnDrawAnotherCardIfRedSuit, actorId: actor.identifier)
        } else if actor.abilities[.onStartTurnDraws3CardsAndKeep2] == true {
            return nil
        } else if actor.abilities[.onStartTurnCanDrawFirstCardFromPlayer] == true {
            return nil
        } else if actor.abilities[.onStartTurnCanDrawFirstCardFromDiscard] == true {
            return nil
        } else {
            return GameMove(name: .startTurn, actorId: actor.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        switch move.name {
        case .startTurn:
            return executeStartTurn(move, in: state)
            
        case .startTurnDrawAnotherCardIfRedSuit:
            return executeStartTurnDrawAnotherCardIfRedSuit(move, in: state)
            
        case .startTurnDraw3CardsAndKeep2:
            return executeStartTurnDraw3CardsAndKeep2(move, in: state)
            
        case .startTurnDrawFirstCardFromDiscard:
            return executeStartTurnDrawFirstCardFromDiscard(move, in: state)
            
        case .startTurnDrawFirstCardFromOtherPlayer:
            return executeStartTurnDrawFirstCardFromOtherPlayer(move, in: state)
            
        default:
            return nil
        }
    }
    
    private func executeStartTurn(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        [.setChallenge(nil),
         .playerSetBangsPlayed(move.actorId, 0),
         .playerPullFromDeck(move.actorId),
         .playerPullFromDeck(move.actorId)]
    }
    
    private func executeStartTurnDrawAnotherCardIfRedSuit(_ move: GameMove,
                                                          in state: GameStateProtocol) -> [GameUpdate]? {
        let secondCard = state.deck[1]
        var updates: [GameUpdate] = [.setChallenge(nil),
                                     .playerSetBangsPlayed(move.actorId, 0),
                                     .playerPullFromDeck(move.actorId),
                                     .playerPullFromDeck(move.actorId),
                                     .playerRevealHandCard(move.actorId, secondCard.identifier)]
        if secondCard.suit.isRed {
            updates.append(.playerPullFromDeck(move.actorId))
        }
        return updates
    }
    
    private func executeStartTurnDraw3CardsAndKeep2(_ move: GameMove,
                                                    in state: GameStateProtocol) -> [GameUpdate]? {
        nil
    }
    
    private func executeStartTurnDrawFirstCardFromDiscard(_ move: GameMove,
                                                          in state: GameStateProtocol) -> [GameUpdate]? {
        nil
    }
    
    private func executeStartTurnDrawFirstCardFromOtherPlayer(_ move: GameMove,
                                                              in state: GameStateProtocol) -> [GameUpdate]? {
        nil
    }
}

extension MoveName {
    static let startTurn = MoveName("startTurn")
    static let startTurnDrawAnotherCardIfRedSuit = MoveName("startTurnDrawAnotherCardIfRedSuit")
    static let startTurnDraw3CardsAndKeep2 = MoveName("startTurnDraw3CardsAndKeep2")
    static let startTurnDrawFirstCardFromOtherPlayer = MoveName("startTurnDrawFirstCardFromOtherPlayer")
    static let startTurnDrawFirstCardFromDiscard = MoveName("startTurnDrawFirstCardFromDiscard")
}
