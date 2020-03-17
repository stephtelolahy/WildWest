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
    var mockDatabase: MockGameDatabaseProtocol!
    var mockRule: MockRuleProtocol!
    var mockEffectRule: MockEffectRuleProtocol!
    var mockAction: MockActionProtocol!
    
    var sut: GameEngineProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        mockRule = MockRuleProtocol().withEnabledDefaultImplementation(RuleProtocolStub())
        mockEffectRule = MockEffectRuleProtocol().withEnabledDefaultImplementation(EffectRuleProtocolStub())
        sut = GameEngine(database: mockDatabase, rules: [mockRule], effectRules: [mockEffectRule])
        mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
    }
    
    func test_ExecuteGameUpdates_IfExecutingAction() {
        // Given
        let mockUpdate1 = MockGameUpdateProtocol().withEnabledDefaultImplementation(GameUpdateProtocolStub())
        let mockUpdate2 = MockGameUpdateProtocol().withEnabledDefaultImplementation(GameUpdateProtocolStub())
        Cuckoo.stub(mockAction) { mock in
            when(mock.execute(in: state(equalTo: mockState))).thenReturn([mockUpdate1, mockUpdate2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockUpdate1).execute(in: database(equalTo: mockDatabase))
        verify(mockUpdate2).execute(in: database(equalTo: mockDatabase))
    }
    
    func test_AddMoves_IfExecutingAction() {
        // Given
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockDatabase).addExecutedMove(action(equalTo: mockAction))
    }
    
    func test_SetMatchingActionsAsValidMoves_IfExecutingAction() {
        // Given
        let matchedAction1 = MockActionProtocol().autoPlay(is: false)
        let matchedAction2 = MockActionProtocol().autoPlay(is: false)
        Cuckoo.stub(mockRule) { mock in
            when(mock.match(with: state(equalTo: mockState))).thenReturn([matchedAction1, matchedAction2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRule).match(with: state(equalTo: mockState))
        let argumentCaptor = ArgumentCaptor<[ActionProtocol]>()
        verify(mockDatabase, atLeastOnce()).setValidMoves(argumentCaptor.capture())
        XCTAssertTrue(argumentCaptor.allValues.count == 2)
        XCTAssertTrue(argumentCaptor.allValues[0].isEmpty)
        XCTAssertTrue(argumentCaptor.allValues[1].count == 2)
        XCTAssertTrue(argumentCaptor.allValues[1][0] as? MockActionProtocol === matchedAction1)
        XCTAssertTrue(argumentCaptor.allValues[1][1] as? MockActionProtocol === matchedAction2)
    }
    
    func test_DoNotGenerateActions_IfGameIsOver() {
        // Given
        Cuckoo.stub(mockState) { mock in
            when(mock.outcome.get).thenReturn(.outlawWin)
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockDatabase).setValidMoves(isEmpty())
        verifyNoMoreInteractions(mockRule)
    }
}
