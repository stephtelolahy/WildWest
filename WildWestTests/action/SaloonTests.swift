//
//  SaloonTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// Saloon
/// Cards with symbols on two lines have two simultaneous effects, one for each line.
/// Here symbols say: “Regain one life point”, and this applies to “All the other players”,
/// and on the next line: “[You] regain one life point”.
/// The overall effect is that all players in play regain one life point.
/// You cannot play a Saloon out of turn when you are losing
/// your last life point: the Saloon is not a Beer!
///
class SaloonTests: XCTestCase {
    
    func test_EachPlayerGainLifePoint_IfPlayingSaloon() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .maxHealth(is: 4)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockPlayer3 = MockPlayerProtocol()
            .identified(by: "p3")
            .health(is: 1)
            .maxHealth(is: 3)
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        
        let sut = Saloon(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(state: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).gainLifePoint(playerId: "p1")
        verify(mockState).gainLifePoint(playerId: "p2")
        verify(mockState).gainLifePoint(playerId: "p3")
    }
    
    func test_OnlyNotMaxHealthPlayerGainLifePoints_IfPlayingSaloon() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
            .maxHealth(is: 4)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: mockPlayer1, mockPlayer2)
        
        let sut = Saloon(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(state: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).gainLifePoint(playerId: "p2")
    }
    
    func test_CanPlaySaloon_IfYourTurnAndOwnCard() {
        // Given
        let sut = SaloonRule()
        let mockCard = MockCardProtocol()
            .named(.saloon)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(state: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Saloon], [Saloon(actorId: "p1", cardId: "c1")])
    }
}
