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
    
    func test_PickOnceCardFromGeneralStore_IfChoosingCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .generalStore(["p1", "p2"]))
        let sut = ChooseCard(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).pullGeneralStore(playerId: "p1", cardId: "c1")
        verify(mockState).setChallenge(equal(to: .generalStore(["p2"])))
    }
    
    func test_CloseChallenge_IfChoosingLastCard() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .challenge(is: .generalStore(["p1"]))
        let sut = ChooseCard(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).pullGeneralStore(playerId: "p1", cardId: "c1")
        verify(mockState).setChallenge(isNil())
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
            when(mock.generalStoreCards.get).thenReturn([card1, card2])
        }
        
        let sut = ChooseCardRule()
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "chooseCard")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertNil(actions?[0].cardId)
        XCTAssertEqual(actions?[0].options as? [ChooseCard], [
            ChooseCard(actorId: "p1", cardId: "c1"),
            ChooseCard(actorId: "p1", cardId: "c2")])
        XCTAssertEqual(actions?[0].options.map { $0.description }, [
            "p1 chooses c1",
            "p1 chooses c2"])
    }
}
