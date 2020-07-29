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
            !actor.inPlay.contains(where: { $0.name == .dynamite }),
            let moves = startTurnMoves(for: actor, in: state) else {
                return nil
        }
        
        guard moves.count == 1 else {
            return nil
        }
        
        return moves.first
    }
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            !actor.inPlay.contains(where: { $0.name == .jail }),
            !actor.inPlay.contains(where: { $0.name == .dynamite }),
            let moves = startTurnMoves(for: actor, in: state) else {
                return nil
        }
        
        guard moves.count > 1 else {
            return nil
        }
        
        return moves
    }
    
    private func startTurnMoves(for actor: PlayerProtocol, in state: GameStateProtocol) -> [GameMove]? {
        var moves = [GameMove(name: .startTurn, actorId: actor.identifier)]
        
        if actor.abilities[.onStartTurnDrawsAnotherCardIfRedSuit] == true {
            moves = [GameMove(name: .startTurnDrawAnotherCardIfRedSuit, actorId: actor.identifier)]
        }
        
        if actor.abilities[.onStartTurnDraws3CardsAndKeep2] == true {
            moves = Array(state.deck[0..<3]).map {
                GameMove(name: .startTurnDraw3CardsAndKeep2,
                         actorId: actor.identifier,
                         discardIds: [$0.identifier])
            }
        }
        
        if actor.abilities[.onStartTurnCanDrawFirstCardFromPlayer] == true {
            let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
            if let targetCards = otherPlayers.targetableCards() {
                targetCards.forEach {
                    moves.append(GameMove(name: .startTurnDrawFirstCardFromOtherPlayer,
                                          actorId: actor.identifier,
                                          targetCard: $0))
                }
            }
        }
        
        if actor.abilities[.onStartTurnCanDrawFirstCardFromDiscard] == true {
            if let topDiscard = state.discardPile.first {
                moves.append(GameMove(name: .startTurnDrawFirstCardFromDiscard,
                                      actorId: actor.identifier,
                                      cardId: topDiscard.identifier))
            }
        }
        
        return moves
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
        var updates: [GameUpdate] = [.setChallenge(nil),
                                     .playerSetBangsPlayed(move.actorId, 0),
                                     .playerPullFromDeck(move.actorId),
                                     .playerPullFromDeck(move.actorId)]
        let secondCard = state.deck[1]
        updates.append(.playerRevealHandCard(move.actorId, secondCard.identifier))
        if secondCard.suit.isRed {
            updates.append(.playerPullFromDeck(move.actorId))
        }
        return updates
    }
    
    private func executeStartTurnDraw3CardsAndKeep2(_ move: GameMove,
                                                    in state: GameStateProtocol) -> [GameUpdate]? {
        var updates: [GameUpdate] = [.setChallenge(nil),
                                     .playerSetBangsPlayed(move.actorId, 0),
                                     .playerPullFromDeck(move.actorId),
                                     .playerPullFromDeck(move.actorId),
                                     .playerPullFromDeck(move.actorId)]
        if let cardId = move.discardIds?.first {
            updates.append(.playerDiscardTopDeck(move.actorId, cardId))
        }
        return updates
    }
    
    private func executeStartTurnDrawFirstCardFromDiscard(_ move: GameMove,
                                                          in state: GameStateProtocol) -> [GameUpdate]? {
        [.setChallenge(nil),
         .playerSetBangsPlayed(move.actorId, 0),
         .playerPullFromDiscard(move.actorId),
         .playerPullFromDeck(move.actorId)]
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
