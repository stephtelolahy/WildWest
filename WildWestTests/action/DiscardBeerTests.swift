//
//  DiscardBeerTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardBeerTests: XCTestCase {
    
    func test_DiscardBeerDescription() {
        // Given
        let sut = DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 discards c1")
    }
    
    func test_DiscardMultipleBeerDescription() {
        // Given
        let sut = DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1", "c2", "c3"])
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 discards c1, c2, c3")
    }
    
    func test_RemoveActorFromShootChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"]))
        let sut = DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(.shoot(["p2", "p3"]))
        ])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2", "p3"]))
        let sut = DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(.indians(["p2", "p3"]))
        ])
    }
    
    func test_RemoveDuelChallenge_IfDiscardingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"]))
        let sut = DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(nil)
        ])
    }
    
    func test_TriggerStartTurnChallenge_IfDiscardBeerOnDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .startTurnDynamiteExploded)
        let sut = DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1", "c2"])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerDiscardHand("p1", "c2"),
            .setChallenge(.startTurn)
        ])
    }
    
}

class DiscardBeerRuleTests: XCTestCase {
    
    func test_CanDiscardBeer_IfIsTargetOfShootAndWillBeEliminated() {
        // Given
        let sut = DiscardBeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [DiscardBeer], [DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])])
    }
    
    func test_CanDiscardBeer_IfIsTargetOfIndiansAndWillBeEliminated() {
        // Given
        let sut = DiscardBeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: .indians(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [DiscardBeer], [DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])])
    }
    
    func test_CanDiscardBeer_IfIsTargetOfDuelAndWillBeEliminated() {
        // Given
        let sut = DiscardBeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: .duel(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [DiscardBeer], [DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1"])])
    }
    
    func test_CanDiscardBeer_IfDynamiteExplodedAndWillBeEliminated() {
        // Given
        let sut = DiscardBeerRule()
        let mockCard1 = MockCardProtocol().named(.beer).identified(by: "c1")
        let mockCard2 = MockCardProtocol().named(.beer).identified(by: "c2")
        let mockCard3 = MockCardProtocol().named(.beer).identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard1, mockCard2, mockCard3)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
            .currentTurn(is: "p1")
            .challenge(is: .startTurnDynamiteExploded)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [DiscardBeer], [DiscardBeer(actorId: "p1", cardsToDiscardIds: ["c1", "c2", "c3"])])
    }
    
    func test_CannotDiscardBeer_IfThereAreTwoPlayersLeft() {
        // Given
        let sut = DiscardBeerRule()
        let mockCard = MockCardProtocol()
            .named(.beer)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
