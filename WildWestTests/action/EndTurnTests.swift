//
//  EndTurnTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Discard excess cards
 Once the second phase is over (you do not want to or cannot play any more
 cards), then you must discard from your hand any cards exceeding your
 hand-size limit. Remember that your hand size limit, at the end of your
 turn, is equal to the number of bullets (i.e. life points) you currently have.
 Then it is the next player’s turn, in clockwise order.
 */
class EndTurnTests: XCTestCase {
    
    func test_EndTurnDescription() {
        // Given
        let sut = EndTurn(actorId: "p1", cardsToDiscardIds: ["c1", "c2"])
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 end turn discarding c1, c2")
    }
    
    func test_ChangeTurnToNextPlayer_IfAPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        let sut = EndTurn(actorId: "p1", cardsToDiscardIds: [])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .setChallenge(.startTurn("p2"))
        ])
    }
    
    func test_ChangeTurnToFirstPlayer_IfLastPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .players(are: mockPlayer1, mockPlayer2)
        
        let sut = EndTurn(actorId: "p2", cardsToDiscardIds: [])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .setChallenge(.startTurn("p1"))
        ])
    }
    
    func test_DiscardExcessCards_IfEndingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        let sut = EndTurn(actorId: "p1", cardsToDiscardIds: ["c1", "c2"])
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerDiscardHand("p1", "c2"),
            .setChallenge(.startTurn("p2"))
        ])
    }
}

class EndTurnRuleTests: XCTestCase {
    
    func test_CanEndTurnWithoutDicardingExcessCards_IfPlayingNoChallenge() {
        // Given
        let sut = EndTurnRule()
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
            .holding(card1, card2, card3)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [EndTurn], [EndTurn(actorId: "p1", cardsToDiscardIds: [])])
    }
    
    func test_CanEndTurnWithDicardingOneExcessCard_IfPlayingNoChallenge() {
        // Given
        let sut = EndTurnRule()
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .holding(card1, card2, card3)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [EndTurn], [
            EndTurn(actorId: "p1", cardsToDiscardIds: ["c1"]),
            EndTurn(actorId: "p1", cardsToDiscardIds: ["c2"]),
            EndTurn(actorId: "p1", cardsToDiscardIds: ["c3"])
        ])
    }
    
    func test_CanEndTurnWithDicardingAllCombinationsOfExcessCards_IfPlayingNoChallenge() {
        // Given
        let sut = EndTurnRule()
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(card1, card2, card3)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [EndTurn], [
            EndTurn(actorId: "p1", cardsToDiscardIds: ["c1", "c2"]),
            EndTurn(actorId: "p1", cardsToDiscardIds: ["c1", "c3"]),
            EndTurn(actorId: "p1", cardsToDiscardIds: ["c2", "c3"])
        ])
    }
}
