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
    
    func test_ExecuteGameUpdates_IfExecutingMove() {
        // Given
        let move = GameMove(name: .startTurn)
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
        let move = GameMove(name: .startTurn)
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockDatabase).addExecutedMove(equal(to: move))
    }
    
    func test_SetValidMoves_IfExecutingMove() {
        // Given
        let move = GameMove(name: .startTurn)
        let validMove = GameMove(name: .play, actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.validMoves(matching: state(equalTo: mockState))).thenReturn([validMove])
        }
        
        // When
        sut.execute(move)
        
        // Assert
        let argumentCaptor = ArgumentCaptor<[String: [GameMove]]>()
        verify(mockDatabase, atLeastOnce()).setValidMoves(argumentCaptor.capture())
        XCTAssertTrue(argumentCaptor.allValues.count == 2)
        XCTAssertEqual(argumentCaptor.allValues[0], [:])
        XCTAssertEqual(argumentCaptor.allValues[1], ["p1": [validMove]])
    }
    
    func test_DoNotGenerateActions_IfGameIsOver() {
        // Given
        let move = GameMove(name: .startTurn)
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
}
