//
//  ChooseCardTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ChooseCardTests: XCTestCase {
    
    func test_ChooseCardDescription() {
        // Given
        let sut = ChooseCard(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 chooses c1")
    }
    
    func test_PickOneCardFromGeneralStore_IfChoosingCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1", "p2"]))
        let sut = ChooseCard(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerPullFromGeneralStore("p1", "c1"),
            .setChallenge(.generalStore(["p2"]))
        ])
    }
    
    func test_RemoveChallenge_IfChoosingLastCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .generalStore(["p1"]))
        let sut = ChooseCard(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerPullFromGeneralStore("p1", "c1"),
            .setChallenge(nil)
        ])
    }
}

class ChooseCardRuleTests: XCTestCase {
    
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
        
        let sut = ChooseCardRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [ChooseCard], [
            ChooseCard(actorId: "p1", cardId: "c1"),
            ChooseCard(actorId: "p1", cardId: "c2")
        ])
    }
}
