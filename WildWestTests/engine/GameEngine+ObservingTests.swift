//
//  GameEngine+ObservingTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 11/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo
import RxTest
import RxSwift

class GameEngine_ObservingTests: XCTestCase {

    private var sut: GameEngine!
    private var mockState: MockGameStateProtocol!
    
    private var stateObservers: [TestableObserver<GameStateProtocol>]!
    private var executedMoveObservers: [TestableObserver<GameMove>]!
    private var validMovesObservers: [TestableObserver<[GameMove]>]!
    private let disposeBag = DisposeBag()

    override func setUp() {
        let mockDatabase = MockGameDatabaseProtocol()
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1").role(is: .sheriff).health(is: 5).withDefault()
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2").role(is: .outlaw).health(is: 4).withDefault()
        mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .allPlayers(are: mockPlayer1, mockPlayer2)
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        DefaultValueRegistry.register(value: .bartCassidy, forType: FigureName.self)
        
        sut = GameEngine(database: mockDatabase,
                         moveMatchers: [],
                         updateExecutor: MockUpdateExecutorProtocol(),
                         commandQueue: MockCommandQueueProtocol())
        
        let scheduler = TestScheduler(initialClock: 0)
        
        stateObservers = Array(1...7).map { index in
            let observer = scheduler.createObserver(GameStateProtocol.self)
            sut.state(observedBy: "p\(index)").subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        executedMoveObservers = Array(1...7).map { _ in
            let observer = scheduler.createObserver(GameMove.self)
            sut.executedMove().subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        validMovesObservers = Array(1...7).map { index in
            let observer = scheduler.createObserver([GameMove].self)
            sut.validMoves(for: "p\(index)").subscribe(observer).disposed(by: disposeBag)
            return observer
        }
    }
    
    func test_AllObserversReveiceInitialState() throws {
        // Given
        // When
        // Assert
        stateObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
    
    func test_AllObserversReceiveEmitedState() {
        // Given
        // When
        sut.emitState(mockState)
        sut.emitState(mockState)
        
        // Assert
        stateObservers.forEach { XCTAssertEqual($0.events.count, 3) }
    }
    
    func test_AllObserversReceiveEmitedExecutedMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        // When
        sut.emitExecutedMove(move)
        
        // Assert
        executedMoveObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
    
    func test_AllObserversReceiveEmitedValidMoves() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        // When
        sut.emitValidMoves(["p1":[move]])
        
        // Assert
        validMovesObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
}