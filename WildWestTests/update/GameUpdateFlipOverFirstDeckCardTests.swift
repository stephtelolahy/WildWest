//
//  GameUpdateFlipOverFirstDeckCardTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdateFlipOverFirstDeckCardTests: XCTestCase {
    
    private let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_DiscardFlippedCard_IfRevealingFromDeck() {
        // Given
        let mockCard = MockCardProtocol()
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard)
            when(mock.state.get).thenReturn(mockState)
        }
        let sut = GameUpdate.flipOverFirstDeckCard
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).deckRemoveFirst()
        verify(mockDatabase).addDiscard(card(equalTo: mockCard))
    }
    
    func test_IncrementBarrelsResolved_IfFlipOverFirstDeckCard() {
        // Given
        let mockState = MockGameStateProtocol().barrelsResolved(is: 0)
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
            when(mock.deckRemoveFirst()).thenReturn(MockCardProtocol())
        }
        let sut = GameUpdate.flipOverFirstDeckCard
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBarrelsResolved(1)
    }
}
