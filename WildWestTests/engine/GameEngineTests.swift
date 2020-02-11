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
    
    func test_ExecuteGameUpdates_IfExecutingCommand() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let mockMutableState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameEngine(state: mockState, mutableState: mockMutableState, rules: [])
        let mockUpdate1 = MockGameUpdateProtocol().withEnabledDefaultImplementation(GameUpdateProtocolStub())
        let mockUpdate2 = MockGameUpdateProtocol().withEnabledDefaultImplementation(GameUpdateProtocolStub())
        let mockAction = MockActionProtocol()
        Cuckoo.stub(mockAction) { mock in
            when(mock.execute(in: state(equalTo: mockState))).thenReturn([mockUpdate1, mockUpdate2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockUpdate1).execute(in: mutableState(equalTo: mockMutableState))
        verify(mockUpdate2).execute(in: mutableState(equalTo: mockMutableState))
    }
    
    func test_AddCommandToHistory_IfExecutingCommand() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let mockMutableState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let sut = GameEngine(state: mockState, mutableState: mockMutableState, rules: [])
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockMutableState).addCommand(action(equalTo: mockAction))
    }
    
    func test_SetMatchingActions_IfExecutingCommand() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let mockMutableState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let action1 = MockActionProtocol()
        let action2 = MockActionProtocol()
        let mockRule1 = MockRuleProtocol()
        let mockRule2 = MockRuleProtocol()
        Cuckoo.stub(mockRule1) { mock in
            when(mock.match(with: state(equalTo: mockState))).thenReturn(nil)
        }
        Cuckoo.stub(mockRule2) { mock in
            when(mock.match(with: state(equalTo: mockState))).thenReturn([action1, action2])
        }
        let sut = GameEngine(state: mockState, mutableState: mockMutableState, rules: [mockRule1, mockRule2])
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRule1).match(with: state(equalTo: mockState))
        verify(mockRule2).match(with: state(equalTo: mockState))
        verify(mockMutableState).setActions(actions(equalTo: [action1, action2]))
    }
    
    func test_DoNotGenerateActions_IfGameIsOver() {
        // Given
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .outcome(is: .sheriffWin)
        let mockMutableState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let mockRule1 = MockRuleProtocol()
        let sut = GameEngine(state: mockState, mutableState: mockMutableState, rules: [mockRule1])
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockMutableState).setActions(isEmpty())
        verifyNoMoreInteractions(mockRule1)
    }
}
