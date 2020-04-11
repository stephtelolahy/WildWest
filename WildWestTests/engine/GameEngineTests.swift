//
//  GameEngineTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import RxSwift
import Cuckoo

class GameEngineTests: XCTestCase {
    
    private var sut: GameEngine!
    private var mockDatabase: MockGameDatabaseProtocol!
    private var mockState: MockGameStateProtocol!
    private var mockMoveMatcher: MockMoveMatcherProtocol!
    private var mockUpdateExecutor: MockUpdateExecutorProtocol!
    private var mockCommandQueue: MockCommandQueueProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
        mockMoveMatcher = MockMoveMatcherProtocol().withEnabledDefaultImplementation(MoveMatcherProtocolStub())
        mockUpdateExecutor = MockUpdateExecutorProtocol().withEnabledDefaultImplementation(UpdateExecutorProtocolStub())
        mockCommandQueue = MockCommandQueueProtocol().withEnabledDefaultImplementation(CommandQueueProtocolStub())
        DefaultValueRegistry.register(value: PublishSubject<GameMove>(), forType: Observable<GameMove>.self)
        
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        
        sut = GameEngine(database: mockDatabase,
                         moveMatchers: [mockMoveMatcher],
                         updateExecutor: mockUpdateExecutor,
                         commandQueue: mockCommandQueue)
    }
    
    func test_QueueAutoPlayMove_IfStartingGame() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.autoPlayMove(matching: state(equalTo: mockState))).thenReturn(move)
        }
        
        // When
        sut.start()
        
        // Assert
        verify(mockCommandQueue).add(equal(to: move))
    }
    
    func test_ApplyUpdates_IfExecutingMove() {
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
    
    func test_SetOutcome_IfGameIsOverOnExecutingMove() {
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
