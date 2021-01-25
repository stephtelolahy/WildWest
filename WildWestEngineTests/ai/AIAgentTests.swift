//
//  AIAgentTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 05/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo
import RxSwift

class AIAgentTests: XCTestCase {
    
    private var sut: AIAgentProtocol!
    private var mockEngine: MockEngineProtocol!
    private var mockDatabase: MockRestrictedDatabaseProtocol!
    private var eventSubject: PublishSubject<GEvent>!
    private var mockState: MockStateProtocol!
    private var mockAI: MockAIProtocol!
    private var mockRoleEstimator: MockRoleEstimatorProtocol!
    
    override func setUp() {
        mockEngine = MockEngineProtocol().withEnabledDefaultImplementation(EngineProtocolStub())
        eventSubject = PublishSubject()
        mockState = MockStateProtocol()
        mockDatabase = MockRestrictedDatabaseProtocol()
        stub(mockDatabase) { mock in
            when(mock.event.get).thenReturn(eventSubject)
            when(mock.state(observedBy: "p1")).thenReturn(BehaviorSubject<StateProtocol>(value: mockState))
        }
        mockAI = MockAIProtocol()
        mockRoleEstimator = MockRoleEstimatorProtocol().withEnabledDefaultImplementation(RoleEstimatorProtocolStub())
        sut = AIAgent(player: "p1", engine: mockEngine, ai: mockAI, roleEstimator: mockRoleEstimator)
    }
    
    func test_UpdateRoleEstimator_IfReceivingMove() {
        // Given
        let move = GMove("m1", actor: "p1")
        sut.observe(mockDatabase)
        
        // When
        eventSubject.onNext(.run(move: move))
        
        // Assert 
        verify(mockRoleEstimator).update(on: equal(to: move))
    }
    
    func test_ExecuteBestMove_IfReceivingAttributedActiveMoves() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        let move2 = GMove("m2", actor: "p1")
        let move3 = GMove("m3", actor: "p1")
        let moves = [move1, move2, move3]
        stub(mockAI) { mock in
            when(mock.bestMove(among: equal(to: moves), in: state(equalTo: mockState))).thenReturn(move2)
        }
        sut.observe(mockDatabase)
        
        // When
        eventSubject.onNext(.activate(moves: moves))
        
        // Assert
        verify(mockEngine).execute(equal(to: move2))
    }
    
    func test_DoNothing_IfReceivingUnattributedActiveMoves() {
        // Given
        let move1 = GMove("m1", actor: "p2")
        let move2 = GMove("m2", actor: "p2")
        let move3 = GMove("m3", actor: "p2")
        let moves = [move1, move2, move3]
        sut.observe(mockDatabase)
        
        // When
        eventSubject.onNext(.activate(moves: moves))
        
        // Assert
        verifyNoMoreInteractions(mockAI)
        verifyNoMoreInteractions(mockEngine)
    }
}
