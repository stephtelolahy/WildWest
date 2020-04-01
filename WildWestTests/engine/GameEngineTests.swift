//
//  GameEngineTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameEngineTests: XCTestCase {
    
    private var sut: GameEngine!
    
    private var mockDatabase: MockGameDatabaseProtocol!
    private var mockState: MockGameStateProtocol!
    private var mockMoveMatcher: MockMoveMatcherProtocol!
    private var mockUpdateExecutor: MockUpdateExecutorProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
        mockMoveMatcher = MockMoveMatcherProtocol().withEnabledDefaultImplementation(MoveMatcherProtocolStub())
        mockUpdateExecutor = MockUpdateExecutorProtocol().withEnabledDefaultImplementation(UpdateExecutorProtocolStub())
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        
        sut = GameEngine(database: mockDatabase,
                         moveMatchers: [mockMoveMatcher],
                         updateExecutor: mockUpdateExecutor,
                         updateDelay: 0)
    }
    
    func test_ExecuteAutoPlayMove_IfStartingGame() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.autoPlayMoves(matching: state(equalTo: mockState))).thenReturn([move])
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([])
        }
        
        // When
        sut.start()
        
        // Assert
        verify(mockMoveMatcher, atLeastOnce()).autoPlayMoves(matching: state(equalTo: mockState))
        verify(mockMoveMatcher, atLeastOnce()).execute(equal(to: move), in: state(equalTo: mockState))
    }
    
    func test_ExecuteGameUpdates_IfExecutingMove() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        let update: GameUpdate = .playerPullFromDeck("p1", 2)
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([update])
        }
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockUpdateExecutor).execute(equal(to: update), in: database(equalTo: mockDatabase))
    }
    
    func test_AddExecutedMoves_IfExecutingMove() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([])
        }
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockDatabase).addExecutedMove(equal(to: move))
    }
    
    func test_SetValidMoves_IfExecutingMove() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        let validMove = GameMove(name: .play, actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.validMoves(matching: state(equalTo: mockState))).thenReturn([validMove])
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([])
        }
        Cuckoo.stub(mockState) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .sheriff),
                MockPlayerProtocol().role(is: .outlaw)
            ])
        }
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockDatabase).setValidMoves(equal(to: ["p1": [validMove]]))
    }
    
    func test_DoNotGenerateActions_IfGameIsOver() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([])
        }
        Cuckoo.stub(mockState) { mock in
            when(mock.outcome.get).thenReturn(.outlawWin)
        }
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockDatabase).setValidMoves(equal(to: [:]))
        verify(mockMoveMatcher, never()).effect(onExecuting: any(), in: any())
        verify(mockMoveMatcher, never()).autoPlayMoves(matching: any())
        verify(mockMoveMatcher, never()).validMoves(matching: any())
    }
    
    func test_SetOutcomeIfGameIsOver() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        let validMove = GameMove(name: .play, actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.validMoves(matching: state(equalTo: mockState))).thenReturn([validMove])
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([])
        }
        Cuckoo.stub(mockState) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .sheriff)
            ])
        }
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockMoveMatcher, never()).autoPlayMoves(matching: any())
        verify(mockMoveMatcher, never()).effect(onExecuting: any(), in: any())
    }
}
