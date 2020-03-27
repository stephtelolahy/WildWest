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
    
    private let sut = GameUpdateExecutor()
    private let mockDatabase = MockGameDatabaseProtocol()
        .withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_MoveCardFromDeckToHand_IfPlayerPullCardFromDeck() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard)
        }
        let update = GameUpdate.playerPullFromDeck("p1", 1)
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerDiscardHand("p1", "c1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerRemoveHand("p1", "c1")
        verify(mockDatabase).addDiscard(card(equalTo: mockCard))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_MoveCardFromHandToInPlay_IfPlayerPutInPlay() {
        // Given
        let mockCard = MockCardProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.playerRemoveHand("p1", "c1")).thenReturn(mockCard)
        }
        let update = GameUpdate.playerPutInPlay("p1", "c1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerDiscardInPlay("p1", "c1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerPullFromOtherHand("p1", "p2", "c2")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerPullFromOtherInPlay("p1", "p2", "c2")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerPutInPlayOfOther("p1", "p2", "c1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerPassInPlayOfOther("p1", "p2", "c1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.playerPullFromGeneralStore("p1", "c1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.setupGeneralStore(3)
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase, times(3)).deckRemoveFirst()
        verify(mockDatabase).addGeneralStore(card(equalTo: mockCard1))
        verify(mockDatabase).addGeneralStore(card(equalTo: mockCard2))
        verify(mockDatabase).addGeneralStore(card(equalTo: mockCard3))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    // MARK: - Set turn
    
    func test_SetTurn_IfSettingTurn() {
        // Given
        let update = GameUpdate.setTurn("p1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setTurn("p1")
    }
    
    func test_ResetBangsPlayed_IfSettingTurn() {
        // Given
        let update = GameUpdate.setTurn("p1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBangsPlayed(0)
    }
    
    // MARK: - SetChallenge
    
    func test_RemoveChallenge_IfSettingNilChallenge() {
        // Given
        let update = GameUpdate.setChallenge(nil)
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(isNil())
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetChallenge_IfSettingChallenge() {
        // Given
        let update = GameUpdate.setChallenge(.startTurn)
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(equal(to: .startTurn))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_IncrementBangsPlayed_IfSettingBangChallenge() {
        // Given
        let mockState = MockGameStateProtocol().bangsPlayed(is: 0)
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let update = GameUpdate.setChallenge(.shoot(["p1"], .bang, "px"))
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBangsPlayed(1)
    }
    
    func test_ResetBarrelsResolved_IfSettingShootChallenge() {
        // Given
        let update = GameUpdate.setChallenge(.shoot(["p1"], .gatling, "px"))
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBarrelsResolved(0)
    }
    
    // MARK: - FlipOverFirstDeck
    
    func test_DiscardFlippedCard_IfRevealingFromDeck() {
        // Given
        let mockCard = MockCardProtocol()
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.deckRemoveFirst()).thenReturn(mockCard)
            when(mock.state.get).thenReturn(mockState)
        }
        let update = GameUpdate.flipOverFirstDeckCard
        
        // When
        sut.execute(update, in: mockDatabase)
        
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
        let update = GameUpdate.flipOverFirstDeckCard
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBarrelsResolved(1)
    }
    
    // MARK: - EliminatePlayer
    
    func test_RemoveFromActivePlayers_IfEliminating() {
        // Given
        let mockPlayer = MockPlayerProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.removePlayer("p1")).thenReturn(mockPlayer)
        }
        let update = GameUpdate.eliminatePlayer("p1")
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).removePlayer("p1")
        verify(mockDatabase).addEliminated(player(equalTo: mockPlayer))
    }
    
    // MARK: - GainLifePoints
    
    func test_playerSetHealth_IfGainLifePoints() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 1))
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let update = GameUpdate.playerGainHealth("p1", 1)
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).state.get()
        verify(mockDatabase).playerSetHealth("p1", 2)
        verifyNoMoreInteractions(mockDatabase)
    }
    
    // MARK: - LooseHealth
    
    func test_AddDamageEvent_IfLooseLifePoints() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 3))
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let update = GameUpdate.playerLooseHealth("p1", 1, .byPlayer("p2"))
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).state.get()
        verify(mockDatabase).playerSetHealth("p1", 2)
        let expectedEvent = DamageEvent(playerId: "p1", source: .byPlayer("p2"))
        verify(mockDatabase).addDamageEvent(equal(to: expectedEvent))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetZeroHealth_IfLooseMoreThanCurrentLifePoints() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 1))
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let update = GameUpdate.playerLooseHealth("p1", 3, .byDynamite)
        
        // When
        sut.execute(update, in: mockDatabase)
        
        // Assert
        verify(mockDatabase).state.get()
        verify(mockDatabase).playerSetHealth("p1", 0)
        let expectedEvent = DamageEvent(playerId: "p1", source: .byDynamite)
        verify(mockDatabase).addDamageEvent(equal(to: expectedEvent))
        verifyNoMoreInteractions(mockDatabase)
    }
}