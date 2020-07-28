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
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            !actor.inPlay.contains(where: { $0.name == .jail }),
            !actor.inPlay.contains(where: { $0.name == .dynamite }) else {
                return nil
        }
        
        if actor.abilities[.onStartTurnDrawsAnotherCardIfRedSuit] == true {
            return nil
            
        } else if actor.abilities[.onStartTurnDraws3CardsAndKeep2] == true {
            return createValidMovesDraws3CardsAndKeep2()
            
        } else if actor.abilities[.onStartTurnCanDrawFirstCardFromPlayer] == true {
            return createValidMovesDrawFirstCardFromPlayer(state: state, actor: actor)
            
        } else if actor.abilities[.onStartTurnCanDrawFirstCardFromDiscard] == true {
            return createValidMovesDrawFirstCardFromDiscard()
            
        } else {
            return nil
        }
    }
    
    private func createValidMovesDrawFirstCardFromPlayer(state: GameStateProtocol,
                                                         actor: PlayerProtocol) -> [GameMove]? {
        var moves: [GameMove] = [GameMove(name: .startTurn, actorId: actor.identifier)]
        
        let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
        guard let targetCards = otherPlayers.targetableCards() else {
            return moves
        }
        
        targetCards.forEach {
            moves.append(GameMove(name: .startTurnDrawFirstCardFromOtherPlayer,
                                  actorId: actor.identifier,
                                  targetCard: $0))
        }
        
        return moves
    }
    
    private func createValidMovesDrawFirstCardFromDiscard() -> [GameMove]? {
        nil
    }
    
    private func createValidMovesDraws3CardsAndKeep2() -> [GameMove]? {
        nil
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
        guard let targetCard = move.targetCard else {
            return nil
        }
        
        var updates: [GameUpdate] = [.setChallenge(nil),
                                     .playerSetBangsPlayed(move.actorId, 0)]
        switch targetCard.source {
        case .randomHand:
            if let player = state.player(targetCard.ownerId),
                let card = player.hand.randomElement() {
                updates.append(.playerPullFromOtherHand(move.actorId, targetCard.ownerId, card.identifier))
            }
        case let .inPlay(targetCardId):
            updates.append(.playerPullFromOtherInPlay(move.actorId, targetCard.ownerId, targetCardId))
        }
        
        updates.append(.playerPullFromDeck(move.actorId))
        
        return updates
    }
}

extension MoveName {
    static let startTurn = MoveName("startTurn")
    static let startTurnDrawAnotherCardIfRedSuit = MoveName("startTurnDrawAnotherCardIfRedSuit")
    static let startTurnDraw3CardsAndKeep2 = MoveName("startTurnDraw3CardsAndKeep2")
    static let startTurnDrawFirstCardFromOtherPlayer = MoveName("startTurnDrawFirstCardFromOtherPlayer")
    static let startTurnDrawFirstCardFromDiscard = MoveName("startTurnDrawFirstCardFromDiscard")
}
