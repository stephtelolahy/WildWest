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
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockAction).execute(state: any())
        verify(mockState).addHistory(any())
    }
    
    func test_SetGeneratedActions_IfRequiredActionsEmpty() {
        // Given
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRules).generateActions(for: any())
        verify(mockState).setActions(any())
    }
    
    func test_SetRequiredActionsToActions_IfRequiredActionsNotEmpty() {
        XCTFail()
    }
}
