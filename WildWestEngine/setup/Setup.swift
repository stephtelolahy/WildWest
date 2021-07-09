//
//  Setup.swift
//  CardGameEngine
//
//  Created by Hugues Stéphano TELOLAHY on 11/1/20.
//

public protocol SetupProtocol {
    func roles(for playersCount: Int) -> [Role]
    func setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol]
    func setupGame(roles: [Role], 
                   cards: [Card], 
                   cardSet: [DeckCard],
                   preferredRole: Role?,
                   preferredFigure: String?) -> StateProtocol
}

public class GSetup: SetupProtocol {
    
    public init() {
    }
    
    public func roles(for playersCount: Int) -> [Role] {
        let order: [Role] = [.sheriff, .outlaw, .outlaw, .renegade, .deputy, .outlaw, .deputy, .renegade]
        guard playersCount <= order.count else {
            return []
        }
        return Array(order.prefix(playersCount))
    }
    
    public func setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol] {
        cardSet.map { deckCard in
            guard let card = cards.first(where: { $0.name == deckCard.name }) else {
                fatalError("Card \(deckCard.name) not found")
            }
            let identifier = "\(deckCard.name)-\(deckCard.value)\(deckCard.suit)"
            return GCard(identifier: identifier,
                         name: card.name,
                         type: card.type,
                         desc: card.desc,
                         abilities: card.abilities,
                         attributes: card.attributes,
                         suit: deckCard.suit,
                         value: deckCard.value)
        }
    }
    
    public func setupGame(roles: [Role], 
                          cards: [Card],
                          cardSet: [DeckCard],
                          preferredRole: Role?, 
                          preferredFigure: String?) -> StateProtocol {
        var deck = setupDeck(cardSet: cardSet.shuffled(), cards: cards)
        let roles = roles.shuffled().starting(with: preferredRole)
        let figures = cards.filter { $0.type == .figure }.shuffled().starting(with: { $0.name == preferredFigure })
        let defaults = cards.filter { $0.type == .default }
        let players = setupPlayers(roles: roles, figures: figures, defaults: defaults, deck: &deck)
        guard let sheriff = players.first(where: { $0.role == .sheriff }) else {
            fatalError("Sheriff not found")
        }
        return GState(players: players.toDictionary(with: { $0.identifier }),
                      initialOrder: players.map { $0.identifier },
                      playOrder: players.map { $0.identifier },
                      turn: sheriff.identifier,
                      phase: 1,
                      deck: deck,
                      discard: [],
                      store: [],
                      hits: [],
                      played: [],
                      history: [])
    }
}

private extension GSetup {
    
    func setupPlayers(roles: [Role],
                      figures: [Card],
                      defaults: [Card],
                      deck: inout [CardProtocol]) -> [PlayerProtocol] {
        roles.enumerated().map { index, role in
            let figure = figures[index]
            guard var health = figure.attributes.bullets else {
                fatalError("Bullets for \(figure.name) not found")
            }
            
            var abilities = figure.abilities
            
            if let playerCard = defaults.first(where: { $0.name == "player" }) {
                abilities.merge(playerCard.abilities) { $1 }
            }
            
            if role == .sheriff {
                health += 1
                
                if let sheriffCard = defaults.first(where: { $0.name == "sheriff" }) {
                    abilities.merge(sheriffCard.abilities) { $1 }
                }
            }
            
            let hand: [CardProtocol] = Array(1...health).map { _ in deck.removeFirst() }
            return GPlayer(identifier: figure.name,
                           name: figure.name,
                           desc: figure.desc,
                           abilities: abilities,
                           attributes: figure.attributes,
                           role: role,
                           maxHealth: health,
                           health: health,
                           hand: hand,
                           inPlay: [])
        }
    }
}
