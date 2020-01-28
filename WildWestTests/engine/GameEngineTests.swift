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
    
    private var sut: GameEngineProtocol!
    private var mockState: MockGameStateProtocol!
    private var mockRules: MockGameRulesProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockRules = MockGameRulesProtocol().withEnabledDefaultImplementation(GameRulesProtocolStub())
        sut = GameEngine(state: mockState, rules: mockRules)
    }
    
    func test_ExposePassedStateInConstructor() {
        // Given
        // When
        // Assert
        let state = try? sut.stateSubject.value()
        XCTAssertNotNil(state)
    }
    
    func test_AddActionToHistory_IfExecuting() {
        // Given
        let mockAction = MockActionProtocol()
            .withEnabledDefaultImplementation(ActionProtocolStub())
            .described(by: "ac")
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockAction).execute(state: state(equalTo: mockState))
        verify(mockState).addHistory(action(describedBy: "ac"))
    }
    
    func test_SetMatchingActions_IfExecuting() {
        // Given
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        let action1 = MockActionProtocol().described(by: "a1")
        let action2 = MockActionProtocol().described(by: "a2")
        Cuckoo.stub(mockRules) { mock in
            when(mock.actions(matching: state(equalTo: mockState))).thenReturn([action1, action2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRules).actions(matching: state(equalTo: mockState))
        verify(mockState).setActions(actions(describedBy: ["a1", "a2"]))
    }
}
