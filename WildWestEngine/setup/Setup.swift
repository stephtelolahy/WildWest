//
//  Setup.swift
//  CardGameEngine
//
//  Created by Hugues Stéphano TELOLAHY on 11/1/20.
//
// swiftlint:disable function_parameter_count

public protocol SetupProtocol {
    func roles(for playersCount: Int) -> [Role]
    func setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol]
    func setupGame(roles: [Role], 
                   cards: [Card], 
                   cardSet: [DeckCard], 
                   defaults: DefaultAbilities, 
                   preferredRole: Role?,
                   preferredFigure: String?) -> StateProtocol
}

public class GSetup: SetupProtocol {
    
    public init() {
    }
    
    public func roles(for playersCount: Int) -> [Role] {
        let order: [Role] = [.sheriff, .outlaw, .outlaw, .renegade, .deputy, .outlaw, .deputy]
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
            return GCard(identifier: deckCard.identifier,
                         name: card.name,
                         type: card.type,
                         desc: card.desc,
                         abilities: card.abilities,
                         suit: deckCard.suit,
                         value: deckCard.value)
        }
    }
    
    public func setupGame(roles: [Role], 
                          cards: [Card],
                          cardSet: [DeckCard],
                          defaults: DefaultAbilities,
                          preferredRole: Role?, 
                          preferredFigure: String?) -> StateProtocol {
        var deck = setupDeck(cardSet: cardSet.shuffled(), cards: cards)
        let roles = roles.shuffled().starting(with: preferredRole)
        let figures = cards.filter { $0.type == .figure }.shuffled().starting(with: { $0.name == preferredFigure })
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
                      played: [])
    }
}

private extension GSetup {
    
    func setupPlayers(roles: [Role],
                      figures: [Card],
                      defaults: DefaultAbilities,
                      deck: inout [CardProtocol]) -> [PlayerProtocol] {
        roles.enumerated().map { index, role in
            let figure = figures[index]
            guard var health = figure.abilities["bullets"] else {
                fatalError("Bullets for \(figure.name) not found")
            }
            var abilities = figure.abilities
            abilities.merge(defaults.common) { $1 }
            if role == .sheriff {
                health += 1
                abilities.merge(defaults.sheriff) { $1 }
            }
            let hand: [CardProtocol] = Array(1...health).map { _ in deck.removeFirst() }
            return GPlayer(identifier: figure.name,
                           name: figure.name,
                           desc: figure.desc,
                           abilities: abilities,
                           role: role,
                           maxHealth: health,
                           health: health,
                           hand: hand,
                           inPlay: [])
        }
    }
}
