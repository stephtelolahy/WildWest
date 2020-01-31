//
//  GameSetupTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameSetupTests: XCTestCase {
    
    private let sut: GameSetupProtocol = GameSetup()
    
    func test_Roles_For4Players() {
        // Given
        // When
        let roles = sut.roles(for: 4)
        
        // Assert
        XCTAssertEqual(roles.count, 4)
        XCTAssertEqual(roles.count(of: .sheriff), 1)
        XCTAssertEqual(roles.count(of: .outlaw), 2)
        XCTAssertEqual(roles.count(of: .renegade), 1)
    }
    
    func test_Roles_For5Players() {
        // Given
        // When
        let roles = sut.roles(for: 5)
        
        // Assert
        XCTAssertEqual(roles.count, 5)
        XCTAssertEqual(roles.count(of: .sheriff), 1)
        XCTAssertEqual(roles.count(of: .outlaw), 2)
        XCTAssertEqual(roles.count(of: .renegade), 1)
        XCTAssertEqual(roles.count(of: .deputy), 1)
    }
    
    func test_Roles_For6Players() {
        // Given
        // When
        let roles = sut.roles(for: 6)
        
        // Assert
        XCTAssertEqual(roles.count, 6)
        XCTAssertEqual(roles.count(of: .sheriff), 1)
        XCTAssertEqual(roles.count(of: .outlaw), 3)
        XCTAssertEqual(roles.count(of: .renegade), 1)
        XCTAssertEqual(roles.count(of: .deputy), 1)
    }
    
    func test_Roles_For7Players() {
        // Given
        // When
        let roles = sut.roles(for: 7)
        
        // Assert
        XCTAssertEqual(roles.count, 7)
        XCTAssertEqual(roles.count(of: .sheriff), 1)
        XCTAssertEqual(roles.count(of: .outlaw), 3)
        XCTAssertEqual(roles.count(of: .renegade), 1)
        XCTAssertEqual(roles.count(of: .deputy), 2)
    }
    
    func test_SetupGameWith4Players() {
        // Given
        let roles: [Role] = [.sheriff, .outlaw, .outlaw, .renegade]
        let cards: [CardProtocol] = Array(1...80).map { MockCardProtocol().identified(by: "c\($0)") }
        let figures: [Figure] = [Figure(ability: .bartCassidy, bullets: 4, imageName: "", description: ""),
                                 Figure(ability: .calamityJanet, bullets: 4, imageName: "", description: ""),
                                 Figure(ability: .joudonais, bullets: 4, imageName: "", description: ""),
                                 Figure(ability: .paulRegret, bullets: 4, imageName: "", description: ""),
                                 Figure(ability: .suzyLafayette, bullets: 4, imageName: "", description: "")]
        
        // When
        let state = sut.setupGame(roles: roles, figures: figures, cards: cards)
        
        // Assert
        // Verify expected number of players
        XCTAssertEqual(state.players.count, 4)
        // ShuffleRolesBetweenPlayers
        XCTAssertTrue(state.players.map { $0.role }.isShuffed(from: roles))
        // ShuffleCharactersBetweenPlayers
        XCTAssertTrue(state.players.allSatisfy { figures.map { $0.ability }.contains($0.ability) })
        // PlayerInitialInPlayIsEmpty
        XCTAssertTrue(state.players.allSatisfy { $0.inPlay.isEmpty })
        // PlayerHandCardsEqualsToHealthPoints
        XCTAssertTrue(state.players.allSatisfy { $0.hand.count == $0.health })
        // Each player has maximal health
        XCTAssertTrue(state.players.allSatisfy { $0.health == $0.maxHealth })
        // InitialDeckContainsShuffleCards
        let distributedCardIds = state.players.map { $0.hand }.flatMap { $0 }.map { $0.identifier }
        let remainingCardIds = cards.map { $0.identifier }.filter { !distributedCardIds.contains($0) }
        let deckCardIds = state.deck.cards.map { $0.identifier }
        XCTAssertTrue(deckCardIds.isShuffed(from: remainingCardIds))
        // SheriffStartsTurn
        XCTAssertEqual(state.players[state.turn].role, .sheriff)
        // SheriffHasOneAdditionalHealth
        XCTAssertEqual(state.players.first { $0.role == .sheriff }?.health, 5)
        // PlayerInitialHealthIsEqualToFigureBullets
        XCTAssertTrue(state.players.filter { $0.role != .sheriff }.allSatisfy { $0.health == 4 })
        // Available actions should be only sherif's start turn
        let sheriff = state.players.first { $0.role == .sheriff }!
        XCTAssertEqual(sheriff.actions as? [StartTurn], [StartTurn(actorId: sheriff.identifier)])
        // Commands is empty
        XCTAssertTrue(state.commands.isEmpty)
    }
}
