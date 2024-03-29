//
//  SetupTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stéphano TELOLAHY on 11/1/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine

class SetupTests: XCTestCase {
    
    private var sut: SetupProtocol!
    
    override func setUp() {
        sut = GSetup()
    }
    
    // MARK: - Roles
    
    func test_Roles_For4Players() {
        // Given
        // When
        let roles = sut.roles(for: 4)
        
        // Assert
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 2)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 1)
    }
    
    func test_Roles_For5Players() {
        // Given
        // When
        let roles = sut.roles(for: 5)
        
        // Assert
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 2)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .deputy }.count, 1)
    }
    
    func test_Roles_For6Players() {
        // Given
        // When
        let roles = sut.roles(for: 6)
        
        // Assert
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 3)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .deputy }.count, 1)
    }
    
    func test_Roles_For7Players() {
        // Given
        // When
        let roles = sut.roles(for: 7)
        
        // Assert
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 3)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .deputy }.count, 2)
    }
    
    func test_Roles_For8Players() {
        // Given
        // When
        let roles = sut.roles(for: 8)
        
        // Assert
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 3)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 2)
        XCTAssertEqual(roles.filter { $0 == .deputy }.count, 2)
    }
    
    // MARK: - Setup Game
    
    func test_ShuffleRole_WhenSetupGame() throws {
        // Given
        let roles: [Role] = [.sheriff, .outlaw, .deputy, .renegade]
        let brown: [Card] = Array(1...80).map { Card(name: "c\($0)", type: .brown) }
        let figure: [Card] = Array(1...16).map { Card(name: "f\($0)", type: .figure, attributes: [.bullets: 4]) }
        let defaults: [Card] = [Card(name: "player", type: .default, abilities: ["a1", "a2"]),
                                Card(name: "sheriff", type: .default, attributes: [.bullets: 1, .silentCard: "jail"], abilities: ["a3"])]
        let cards: [Card] = brown + figure + defaults
        let cardSet: [DeckCard] = Array(1...80).map { DeckCard(name: "c\($0)", value: "v\($0)", suit: "s\($0)") }
        
        // When
        let state = sut.setupGame(roles: roles, cards: cards, cardSet: cardSet, preferredRole: nil, preferredFigure: nil)
        
        // Assert
        
        // <PLAYERS>
        let players = state.players.values
        XCTAssertEqual(players.count, 4)
        XCTAssertTrue(players.map { $0.role }.contains(sameElementsAs: roles)) // Shuffle roles
        
        XCTAssertTrue(players.map { $0.name }.allSatisfy { figure.map { $0.name }.contains($0) }) // Shuffle figures
        XCTAssertTrue(players.filter { $0.role != .sheriff }.allSatisfy { $0.attributes[.bullets] as? Int == 4 }) // Max health is number of bullets
        XCTAssertTrue(players.allSatisfy { $0.health == $0.attributes[.bullets] as? Int }) // Each player has maximal health
        XCTAssertTrue(players.allSatisfy { $0.inPlay.isEmpty }) // InPlay empty
        XCTAssertTrue(players.allSatisfy { $0.hand.count == $0.health }) // Hand cards equals health
        players.forEach {
            XCTAssertTrue($0.abilities.contains("a1"))
            XCTAssertTrue($0.abilities.contains("a2"))
        }
        
        let sheriff = try XCTUnwrap(players.first { $0.role == .sheriff })
        XCTAssertEqual(sheriff.attributes[.bullets] as? Int, 5) // Sheriff has one additional health
        XCTAssertEqual(sheriff.attributes[.silentCard] as? String, "jail")
        XCTAssertTrue(sheriff.abilities.contains("a3"))
        // </PLAYERS>
        
        // <STATE>
        XCTAssertTrue(state.players.values.compactMap { $0.role }.contains(sameElementsAs: roles)) // all roles are present
        XCTAssertEqual(state.initialOrder.count, 4) // All players are in initial order
        XCTAssertEqual(state.playOrder, state.initialOrder)
        XCTAssertEqual(state.turn, sheriff.identifier) // Turn is sheriff
        XCTAssertEqual(state.phase, 1) // current phase is 1
        XCTAssertTrue(state.discard.isEmpty) // Discard pile is empty
        XCTAssertTrue(state.store.isEmpty) // Store is empty
        XCTAssertNil(state.hit) // No hit
        XCTAssertTrue(state.played.isEmpty) // Played abilities are empty
        let distributedCards: [String] = players.map { $0.hand }.flatMap { $0 }.map { $0.identifier }
        let expectedDeck: [String] = cardSet.map { "\($0.name)-\($0.value)\($0.suit)" }.filter { !distributedCards.contains($0) }
        XCTAssertTrue(state.deck.map { $0.identifier }.contains(sameElementsAs: expectedDeck)) // Shuffle cards to deck
        // </STATE>
    }
    
    func test_SetupWithPreferredRoleAndFigure() throws {
        // Given
        let roles: [Role] = [.sheriff, .outlaw, .deputy, .renegade]
        let brown: [Card] = Array(1...80).map { Card(name: "c\($0)", type: .brown) }
        let figure: [Card] = Array(1...16).map { Card(name: "f\($0)", type: .figure, attributes: [.bullets: 4]) }
        let cards: [Card] = brown + figure
        let cardSet: [DeckCard] = Array(1...80).map { DeckCard(name: "c\($0)", value: "v\($0)", suit: "s\($0)") }
        
        // When
        let state = sut.setupGame(roles: roles, cards: cards, cardSet: cardSet, preferredRole: .deputy, preferredFigure: "f12")
        
        // Assert
        let firstPlayer = try XCTUnwrap(state.players[state.playOrder[0]])
        XCTAssertEqual(firstPlayer.role, .deputy)
        XCTAssertEqual(firstPlayer.name, "f12")
    }
    
    func test_InitialDeckIsShuffledFromCardSet() throws {
        // Given
        let roles: [Role] = [.sheriff, .outlaw, .deputy, .renegade]
        let brown: [Card] = Array(1...80).map { Card(name: "c\($0)", type: .brown) }
        let figure: [Card] = Array(1...16).map { Card(name: "f\($0)", type: .figure, attributes: [.bullets: 4]) }
        let cards: [Card] = brown + figure
        let cardSet: [DeckCard] = Array(1...80).map { DeckCard(name: "c\($0)", value: "v\($0)", suit: "s\($0)") }
        
        // When
        let state = sut.setupGame(roles: roles, cards: cards, cardSet: cardSet, preferredRole: nil, preferredFigure: nil)
        
        // Assert
        let player1 = try XCTUnwrap(state.players[state.playOrder[0]])
        XCTAssertNotEqual(player1.hand.map { $0.name }, ["c1", "c2", "c3", "c4"])
    }
    
    func test_setupDeck() throws {
        // Given
        let cards: [Card] = [Card(name: "c1", type: .brown),
                             Card(name: "c2", type: .blue) ]
        let cardSet: [DeckCard] = Array(1...2).map { DeckCard(name: "c\($0)", value: "v\($0)", suit: "s\($0)") }
        
        // When
        let playCards = sut.setupDeck(cardSet: cardSet, cards: cards)
        
        // Assert
        XCTAssertEqual(playCards.count, 2)
        
        XCTAssertEqual(playCards[0].identifier, "c1-v1s1")
        XCTAssertEqual(playCards[0].name, "c1")
        XCTAssertEqual(playCards[0].type, .brown)
        XCTAssertEqual(playCards[0].value, "v1")
        XCTAssertEqual(playCards[0].suit, "s1")
        
        XCTAssertEqual(playCards[1].identifier, "c2-v2s2")
        XCTAssertEqual(playCards[1].name, "c2")
        XCTAssertEqual(playCards[1].type, .blue)
        XCTAssertEqual(playCards[1].value, "v2")
        XCTAssertEqual(playCards[1].suit, "s2")
        
    }
}

private extension Array where Element: Equatable {
    func contains(sameElementsAs other: [Element]) -> Bool {
        guard self.count == other.count else {
            return false
        }
        
        return self.allSatisfy { element in
            self.filter { $0 == element }.count == other.filter { $0 == element }.count
        }
    }
}

private extension Card {
    init(name: String, type: CardType, attributes: [CardAttributeKey: Any] = [:], abilities: Set<String> = []) {
        self.init(name: name, type: type, desc: "", attributes: attributes, abilities: abilities)
    }
}
