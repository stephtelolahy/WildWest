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
    
    var mockState: MockGameStateProtocol!
    var mockMutableState: MockMutableGameStateProtocol!
    var mockRule: MockRuleProtocol!
    var mockCalculator: MockOutcomeCalculatorProtocol!
    var mockAction: MockActionProtocol!
    
    var sut: GameEngineProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockMutableState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        mockRule = MockRuleProtocol().withEnabledDefaultImplementation(RuleProtocolStub())
        mockCalculator = MockOutcomeCalculatorProtocol().withEnabledDefaultImplementation(OutcomeCalculatorProtocolStub())
        sut = GameEngine(state: mockState, mutableState: mockMutableState, rules: [mockRule], calculator: mockCalculator)
        mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
    }
    
    func test_ExecuteGameUpdates_IfExecutingCommand() {
        // Given
        let mockUpdate1 = MockGameUpdateProtocol().withEnabledDefaultImplementation(GameUpdateProtocolStub())
        let mockUpdate2 = MockGameUpdateProtocol().withEnabledDefaultImplementation(GameUpdateProtocolStub())
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
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockMutableState).addCommand(action(equalTo: mockAction))
    }
    
    func test_SetMatchingActions_IfExecutingCommand() {
        // Given
        let matchedAction1 = MockActionProtocol()
        let matchedAction2 = MockActionProtocol()
        Cuckoo.stub(mockRule) { mock in
            when(mock.match(with: state(equalTo: mockState))).thenReturn([matchedAction1, matchedAction2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRule).match(with: state(equalTo: mockState))
        verify(mockMutableState).setActions(actions(equalTo: [matchedAction1, matchedAction2]))
    }
    
    func test_DoNotGenerateActions_IfGameIsOver() {
        // Given
        Cuckoo.stub(mockState) { mock in
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().role(is: .deputy),
                MockPlayerProtocol().role(is: .renegade),
                MockPlayerProtocol().role(is: .outlaw)
            ])
        }
        Cuckoo.stub(mockCalculator) { mock in
            when(mock.outcome(for: any())).thenReturn(.outlawWin)
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockCalculator).outcome(for: equal(to: [.deputy, .renegade, .outlaw]))
        verify(mockMutableState).setOutcome(equal(to: .outlawWin))
        verify(mockMutableState).setActions(isEmpty())
        verifyNoMoreInteractions(mockRule)
    }
}
