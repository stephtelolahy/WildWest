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
    private var mockPlayer1: MockPlayerProtocol!
    private var mockPlayer2: MockPlayerProtocol!
    
    override func setUp() {
        mockPlayer1 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p1")
        mockPlayer2 = MockPlayerProtocol()
            .withEnabledDefaultImplementation(PlayerProtocolStub())
            .identified(by: "p2")
        
        mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: mockPlayer1, mockPlayer2)
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
    
    func test_AddActionToCommands_IfExecuting() {
        // Given
        let mockAction = MockActionProtocol()
            .withEnabledDefaultImplementation(ActionProtocolStub())
            .described(by: "ac")
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockAction).execute(state: state(equalTo: mockState))
        verify(mockState).addCommand(action(describedBy: "ac"))
    }
    
    func test_SetMatchingActions_IfExecuting() {
        // Given
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        let action1 = MockActionProtocol()
            .described(by: "a1")
            .actorId(is: "p1")
        let action2 = MockActionProtocol()
            .described(by: "a2")
            .actorId(is: "p1")
        Cuckoo.stub(mockRules) { mock in
            when(mock.actions(matching: state(equalTo: mockState))).thenReturn([action1, action2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRules).actions(matching: state(equalTo: mockState))
        verify(mockPlayer1).setActions(actions(describedBy: ["a1", "a2"]))
        verify(mockPlayer2).setActions(isEmpty())
    }
}
