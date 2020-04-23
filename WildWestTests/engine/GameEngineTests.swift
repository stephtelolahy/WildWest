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
    private var mockEventQueue: MockEventQueueProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
        mockMoveMatcher = MockMoveMatcherProtocol().withEnabledDefaultImplementation(MoveMatcherProtocolStub())
        mockUpdateExecutor = MockUpdateExecutorProtocol().withEnabledDefaultImplementation(UpdateExecutorProtocolStub())
        mockEventQueue = MockEventQueueProtocol().withEnabledDefaultImplementation(EventQueueProtocolStub())
        DefaultValueRegistry.register(value: PublishSubject<GameEvent>(), forType: Observable<GameEvent>.self)
        
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.stateSubject.get).thenReturn(BehaviorSubject(value: mockState))
        }
        
        sut = GameEngine(database: mockDatabase,
                         moveMatchers: [mockMoveMatcher],
                         updateExecutor: mockUpdateExecutor,
                         eventQueue: mockEventQueue)
    }
    
    func test_ExecuteAutoPlayMove_IfStartingGame() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.autoPlayMove(matching: state(equalTo: mockState))).thenReturn(move)
        }
        
        // When
        sut.start()
        
        // Assert
        verify(mockEventQueue).add(equal(to: GameEvent(move: move)))
    }
    
    func test_QueueMove_IfExecuting() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        
        // When
        sut.execute(move)
        
        // Assert
        verify(mockEventQueue).add(equal(to: GameEvent(move: move)))
    }
    /*
    func test_UpdateState_OnExecutingMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
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
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
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
    
    func test_QueueEffects_IfMatchingOnExecutingMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        let effect = GameMove(name: MoveName("m2"), actorId: "p2")
        let update: GameUpdate = .playerPullFromDeck("p1", 2)
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([update])
            when(mock.effect(onExecuting: equal(to: move), in: state(equalTo: mockState))).thenReturn(effect)
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
        verify(mockEventQueue).add(equal(to: GameEvent(move: effect)))
    }
    
    func test_QueueAutoPlay_IfMatchingOnExecutingMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        let autoplay = GameMove(name: MoveName("m2"), actorId: "p2")
        let update: GameUpdate = .playerPullFromDeck("p1", 2)
        Cuckoo.stub(mockMoveMatcher) { mock in
            when(mock.execute(equal(to: move), in: state(equalTo: mockState))).thenReturn([update])
            when(mock.autoPlayMove(matching: state(equalTo: mockState))).thenReturn(autoplay)
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
        verify(mockEventQueue).add(equal(to: GameEvent(move: autoplay)))
    }
    */
}
