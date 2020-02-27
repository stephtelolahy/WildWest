//
//  GameUpdateTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdateTests: XCTestCase {
    
    let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_SetOutcome() {
        // Given
        let sut = GameUpdate.setOutcome(.outlawWin)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setOutcome(equal(to: .outlawWin))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetTurnAndResetBangsPlayed_IfSettingTurn() {
        // Given
        let sut = GameUpdate.setTurn("p1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setTurn("p1")
        verify(mockDatabase).setBangsPlayed(0)
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_RemoveChallenge() {
        // Given
        let sut = GameUpdate.setChallenge(nil)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(isNil())
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_ResetResolvedBarrels_IfSettingShootChallenge() {
        // Given
        let sut = GameUpdate.setChallenge(.shoot(["p1"]))
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(equal(to: .shoot(["p1"])))
        verify(mockDatabase).setBarrelsResolved(0)
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetTurnAndChallenge_IfSettingStartTurnChallenge() {
        // Given
        let sut = GameUpdate.setChallenge(.startTurn("p1"))
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(equal(to: .startTurn("p1")))
        verify(mockDatabase).setTurn("p1")
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetBangsPlayed() {
        // Given
        let sut = GameUpdate.setBangsPlayed(1)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBangsPlayed(1)
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetBarrelsResolved() {
        // Given
        let sut = GameUpdate.setBarrelsResolved(1)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBarrelsResolved(1)
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromDeckToHand_IfPlayerPullCardFromDeck() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromDeck("p1", 1)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).deckRemoveFirst()
        verify(mockDatabase).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromHandToDiscard_IfPlayerDiscardHand() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerDiscardHand("p1", "c1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveHand("p1", "c1")
        verify(mockDatabase).addDiscard(card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_playerSetHealth() {
        // Given
        let sut = GameUpdate.playerSetHealth("p1", 2)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerSetHealth("p1", 2)
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromHandToInPlay_IfPlayerPutInPlay() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPutInPlay("p1", "c1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveHand("p1", "c1")
        verify(mockDatabase).playerAddInPlay("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromInPlayToDiscard_IfPlayerDiscardInPlay() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveInPlay("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerDiscardInPlay("p1", "c1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveInPlay("p1", "c1")
        verify(mockDatabase).addDiscard(card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_AddCardToHand_IfPlayerPullFromOtherHand() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveHand("p2", "c2")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromOtherHand("p1", "p2", "c2")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveHand("p2", "c2")
        verify(mockDatabase).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_AddCardToHand_IfPlayerPullFromOtherInPlay() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveInPlay("p2", "c2")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromOtherInPlay("p1", "p2", "c2")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveInPlay("p2", "c2")
        verify(mockDatabase).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromHandToInPlayOfOther_IfPlayerPutInPlayOfOther() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPutInPlayOfOther("p1", "p2", "c1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveHand("p1", "c1")
        verify(mockDatabase).playerAddInPlay("p2", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromInPlayToOtherInPlay_IfPlayerPassInPlayOfOther() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveInPlay("p1", "c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPassInPlayOfOther("p1", "p2", "c1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveInPlay("p1", "c1")
        verify(mockDatabase).playerAddInPlay("p2", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_PlayerPullFromGeneralStore() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.removeGeneralStore("c1")).thenReturn(mockCard)
        }
        let sut = GameUpdate.playerPullFromGeneralStore("p1", "c1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).removeGeneralStore("c1")
        verify(mockDatabase).playerAddHand("p1", card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetupGeneralStore() {
        // Given
        let mockCard1 = MockCardProtocol()
        let mockCard2 = MockCardProtocol()
        let mockCard3 = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard1, mockCard2, mockCard3)
        }
        let sut = GameUpdate.setupGeneralStore(3)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase, times(3)).deckRemoveFirst()
        verify(mockDatabase).addGeneralStore(card(equalTo: mockCard1))
        verify(mockDatabase).addGeneralStore(card(equalTo: mockCard2))
        verify(mockDatabase).addGeneralStore(card(equalTo: mockCard3))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_DiscardFlippedCard_IfRevealingFromDeck() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard)
        }
        let sut = GameUpdate.flipOverFirstDeckCard
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).deckRemoveFirst()
        verify(mockDatabase).addDiscard(card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_RemoveFromActive_IfPlayerEliminated() {
        // Given
        let mockPlayer = MockPlayerProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.removePlayer("p1")).thenReturn(mockPlayer)
        }
        let sut = GameUpdate.eliminatePlayer("p1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).removePlayer("p1")
        verify(mockDatabase).addEliminated(player(equalTo: mockPlayer))
    }
    
    func test_DiscardAllCards_IfPlayerEliminated() {
        // Given
        let mockCard1 = MockCardProtocol()
        let mockCard2 = MockCardProtocol()
        let mockCard3 = MockCardProtocol()
        let mockCard4 = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveAllHand("p1")).thenReturn([mockCard1, mockCard2])
            when(mock.playerRemoveAllInPlay("p1")).thenReturn([mockCard3, mockCard4])
        }
        
        // Given
        let sut = GameUpdate.eliminatePlayer("p1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveAllHand("p1")
        verify(mockDatabase).playerRemoveAllInPlay("p1")
        verify(mockDatabase).addDiscard(card(equalTo: mockCard1))
        verify(mockDatabase).addDiscard(card(equalTo: mockCard2))
        verify(mockDatabase).addDiscard(card(equalTo: mockCard3))
        verify(mockDatabase).addDiscard(card(equalTo: mockCard4))
    }
}
