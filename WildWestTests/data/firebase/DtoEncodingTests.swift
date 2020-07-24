//
//  DtoEncodingTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DtoEncodingTests: XCTestCase {
    
    private var sut: DtoEncoder!
    
    override func setUp() {
        let mockKeyGenerator = MockKeyGeneratorProtocol().withEnabledDefaultImplementation(KeyGeneratorProtocolStub())
        sut = DtoEncoder(allCards: [], keyGenerator: mockKeyGenerator)
    }
    
    func test_DamageEncoding() throws {
        // Given
        let events: [DamageEvent?] = [nil,
                                      DamageEvent(damage: 1, source: .byPlayer("px")),
                                      DamageEvent(damage: 3, source: .byDynamite)]
        
        try events.forEach { event in
            // When
            let encoded = sut.encode(damageEvent: event)
            let decoded = try sut.decode(damageEvent: encoded)
            
            // Assert
            XCTAssertEqual(decoded, event)
        }
    }
    
    func test_ChallengeEncoding() throws {
        // Given
        let challenges: [Challenge?] = [nil,
                                        Challenge(name: .startTurn),
                                        Challenge(name: .dynamiteExploded, damage: 3),
                                        Challenge(name: .bang, targetIds: ["p1"]),
                                        Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 1),
                                        Challenge(name: .bang, targetIds: ["p2"], counterNeeded: 1),
                                        Challenge(name: .bang, targetIds: ["p1"], counterNeeded: 2, barrelsPlayed: 1),
                                        Challenge(name: .duel, targetIds: ["p1", "p2"]),
                                        Challenge(name: .indians, targetIds: ["p1", "p2"]),
                                        Challenge(name: .gatling, targetIds: ["p3", "p4", "p1"]),
                                        Challenge(name: .generalStore, targetIds: ["p1", "p2", "p3", "p4"])]
        
        try challenges.forEach { challenge in
            // When
            let encoded = sut.encode(challenge: challenge)
            let decoded = try sut.decode(challenge: encoded)
            
            // Assert
            XCTAssertEqual(decoded, challenge)
        }
    }
    
    func test_MoveEncoding() throws {
        // Given
        let moves: [GameMove] = [GameMove(name: .startTurn, actorId: "p1"),
                                 GameMove(name: .useBarrel, actorId: "p1"),
                                 GameMove(name: .drawsCardWhenHandIsEmpty, actorId: "p1"),
                                 GameMove(name: .beer, actorId: "p1", cardId: "c1"),
                                 GameMove(name: .equip, actorId: "p1", cardId: "c1"),
                                 GameMove(name: .stayInJail, actorId: "p1", cardId: "c1"),
                                 GameMove(name: .dynamiteExploded, actorId: "p1", cardId: "c1"),
                                 GameMove(name: .stagecoach, actorId: "p1", cardId: "c1"),
                                 GameMove(name: .jail, actorId: "p1", cardId: "c1", targetId: "p2"),
                                 GameMove(name:.catBalou, actorId: "p1", cardId: "c1", targetCard: TargetCard(ownerId: "p2", source: .randomHand)),
                                 GameMove(name: .panic, actorId: "p1", cardId: "c1", targetCard: TargetCard(ownerId: "p3", source: .inPlay("c3"))),
                                 GameMove(name: .discard2CardsFor1Life, actorId: "p1", discardIds: ["c1", "c2"])]
        
        try moves.forEach { move in
            // When
            let encoded = sut.encode(move: move)
            let decoded = try sut.decode(move: encoded)
            
            // Assert
            XCTAssertEqual(decoded, move)
        }
    }
    
    func test_UpdateEncoding() throws {
        // Given
        let updates: [GameUpdate] = [.setTurn("p1"),
                                     .setChallenge(Challenge(name: .startTurn)),
                                     .setChallenge(nil),
                                     .flipOverFirstDeckCard,
                                     .setupGeneralStore(7),
                                     .playerPullFromDeck("p1"),
                                     .playerSetBangsPlayed("p1", 1),
                                     .playerSetHealth("p1", 3),
                                     .playerSetDamage("p1", DamageEvent(damage: 2, source: .byDynamite)),
                                     .playerDiscardHand("p1", "c1"),
                                     .playerPutInPlay("p1", "c1"),
                                     .playerDiscardInPlay("p1", "c1"),
                                     .playerPullFromGeneralStore("p1", "c1"),
                                     .playerRevealHandCard("p1", "c1"),
                                     .playerPullFromOtherHand("p1", "p2", "c1"),
                                     .playerPullFromOtherInPlay("p1", "p2", "c1"),
                                     .playerPutInPlayOfOther("p1", "p2", "c1"),
                                     .playerPassInPlayOfOther("p1", "p2", "c1")]
        
        try updates.forEach { update in
            // When
            let encoded = sut.encode(update: update)
            let decoded = try sut.decode(update: encoded)
            
            // Assert
            XCTAssertEqual(decoded, update)
        }
    }
    
    func test_UserInfoEncoding() throws {
        // Given
        let user = WUserInfo(id: "1", name: "user1", photoUrl: "https://photo1.png")
        
        // When
        let encoded = sut.encode(user: user)
        let decoded = try sut.decode(user: encoded)
        
        // Assert
        XCTAssertEqual(decoded, user)
    }
    
    func test_UserStatusIdleEncoding() throws {
        // Given
        let status = UserStatus.idle
        
        // When
        let encoded = sut.encode(status: status)
        
        // Assert
        XCTAssertNil(encoded)
    }
    
    func test_UserStatusWaitingEncoding() throws {
        // Given
        let status = UserStatus.waiting
        
        // When
        // When
        let encoded = sut.encode(status: status)
        let decoded = try sut.decode(status: encoded!)
        
        // Assert
        XCTAssertEqual(decoded, status)
    }
    
    func test_UserStatusPlayingEncoding() throws {
        // Given
        let status = UserStatus.playing(gameId: "g1", playerId: "p1")
        
        // When
        // When
        let encoded = sut.encode(status: status)
        let decoded = try sut.decode(status: encoded!)
        
        // Assert
        XCTAssertEqual(decoded, status)
    }
}
