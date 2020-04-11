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
        /*
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.autoPlayMove(matching: state(equalTo: mockState))).thenReturn(move)
        }
        
        // When
        sut.start()
        
        // Assert
        // TODO: assert add in moves queue
        */
        XCTFail()
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
    
    func test_SetOutcomeIfGameIsOver() {
        // Given
        let move = GameMove(name: MoveName("dummy"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
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
        verify(mockDatabase).setOutcome(equal(to: .sheriffWin))
    }
}
