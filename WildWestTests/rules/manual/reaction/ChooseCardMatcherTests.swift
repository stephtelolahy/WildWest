//
//  ChooseCardMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ChooseCardMatcherTests: XCTestCase {

    private let sut = ChooseCardMatcher()
    
    func test_CanSelectCard_IfChallengeIsGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1", "p2"]))
            .players(are: MockPlayerProtocol().identified(by: "p1"))
        Cuckoo.stub(mockState) { mock in
            let card1 = MockCardProtocol().identified(by: "c1")
            let card2 = MockCardProtocol().identified(by: "c2")
            when(mock.generalStore.get).thenReturn([card1, card2])
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .choose, actorId: "p1", cardId: "c1"),
                               GameMove(name: .choose, actorId: "p1", cardId: "c2")])
    }
    
    func test_CanSelectLastCard_IfChallengeIsGeneralStore() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1"]))
            .players(are: MockPlayerProtocol().identified(by: "p1"))
        Cuckoo.stub(mockState) { mock in
            let card1 = MockCardProtocol().identified(by: "c1")
            when(mock.generalStore.get).thenReturn([card1])
        }
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .choose, actorId: "p1", cardId: "c1")])
    }

    func test_PickOneCardFromGeneralStore_IfChoosingCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1", "p2"]))
        let move = GameMove(name: .choose, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromGeneralStore("p1", "c1"),
                                 .setChallenge(.generalStore(["p2"]))])
    }
    
    func test_RemoveChallenge_IfChoosingLastCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1"]))
        let move = GameMove(name: .choose, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromGeneralStore("p1", "c1"),
                                 .setChallenge(nil)])
    }
}
