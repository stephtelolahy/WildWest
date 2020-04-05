//
//  GameSetupTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameSetupTests: XCTestCase {
    
    private let sut = GameSetup()
    
    func test_Roles_For4Players() {
        // Given
        // When
        let roles = sut.roles(for: 4)
        
        // Assert
        XCTAssertEqual(roles.count, 4)
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 2)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 1)
    }
    
    func test_Roles_For5Players() {
        // Given
        // When
        let roles = sut.roles(for: 5)
        
        // Assert
        XCTAssertEqual(roles.count, 5)
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
        XCTAssertEqual(roles.count, 6)
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
        XCTAssertEqual(roles.count, 7)
        XCTAssertEqual(roles.filter { $0 == .sheriff }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .outlaw }.count, 3)
        XCTAssertEqual(roles.filter { $0 == .renegade }.count, 1)
        XCTAssertEqual(roles.filter { $0 == .deputy }.count, 2)
    }
    
    func test_SetupGameWith4Players() {
        // Given
        let roles: [Role] = [.sheriff, .outlaw, .outlaw, .renegade]
        let cards: [CardProtocol] = Array(1...80).map { MockCardProtocol().identified(by: "c\($0)") }
        let figureNames: [FigureName] = [.bartCassidy, .blackJack, .calamityJanet, .elGringo]
        let figures: [FigureProtocol] = Array(0...3).map {
            MockFigureProtocol()
                .named(figureNames[$0])
                .bullets(is: 4)
                .withEnabledDefaultImplementation(FigureProtocolStub())
        }
        
        // When
        let state = sut.setupGame(roles: roles, figures: figures, cards: cards)
        
        // Assert
        // Verify expected number of players
        XCTAssertEqual(state.players.count, 4)
        // ShuffleRolesBetweenPlayers
        XCTAssertEqual(state.players.map { $0.role }, roles)
        // ShuffleCharactersBetweenPlayers
        XCTAssertTrue(state.players.allSatisfy { figures.map { $0.name }.contains($0.figureName) })
        // PlayerInitialInPlayIsEmpty
        XCTAssertTrue(state.players.allSatisfy { $0.inPlay.isEmpty })
        // PlayerHandCardsEqualsToHealthPoints
        XCTAssertTrue(state.players.allSatisfy { $0.hand.count == $0.health })
        // Each player has maximal health
        XCTAssertTrue(state.players.allSatisfy { $0.health == $0.maxHealth })
        // Initial damage is nil
        XCTAssertTrue(state.players.allSatisfy { $0.lastDamage == nil })
        // Bangs played is 0
        XCTAssertTrue(state.players.allSatisfy { $0.bangsPlayed == 0 })
        // InitialDeckContainsShuffleCards
        let distributedCardIds = state.players.map { $0.hand }.flatMap { $0 }.map { $0.identifier }
        let remainingCardIds = cards.map { $0.identifier }.filter { !distributedCardIds.contains($0) }
        let deckCardIds = state.deck.map { $0.identifier }
        XCTAssertEqual(deckCardIds, remainingCardIds)
        // Discard pile is empty
        XCTAssertTrue(state.discardPile.isEmpty)
        // PlayerInitialHealthIsEqualToFigureBullets
        XCTAssertTrue(state.players.filter { $0.role != .sheriff }.allSatisfy { $0.health == 4 })
        
        // SheriffHasOneAdditionalHealth
        let sheriff = state.players.first { $0.role == .sheriff }!
        XCTAssertEqual(sheriff.health, 5)
        // Valid moves is empty
        XCTAssertTrue(state.validMoves.isEmpty)
        // Executed moves is empty
        XCTAssertTrue(state.executedMoves.isEmpty)
        // Turn is sheriff
        XCTAssertEqual(state.turn, sheriff.identifier)
        // Challenge sheriff start turn
        XCTAssertEqual(state.challenge, Challenge(name: .startTurn))
    }
}
