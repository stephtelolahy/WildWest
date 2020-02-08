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
    private var mockRule1: MockRuleProtocol!
    private var mockRule2: MockRuleProtocol!
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
        mockRule1 = MockRuleProtocol().withEnabledDefaultImplementation(RuleProtocolStub())
        mockRule2 = MockRuleProtocol().withEnabledDefaultImplementation(RuleProtocolStub())
        sut = GameEngine(state: mockState, rules: [mockRule1, mockRule2])
    }
    
    func test_AddActionToCommands_IfExecuting() {
        // Given
        let mockAction = MockActionProtocol()
            .withEnabledDefaultImplementation(ActionProtocolStub())
            .described(by: "ac")
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockAction).execute(in: state(equalTo: mockState))
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
        let genericAction = GenericAction(name: "ac",
                                          actorId: "p1",
                                          cardId: nil,
                                          options: [action1, action2])
        Cuckoo.stub(mockRule1) { mock in
            when(mock.match(with: state(equalTo: mockState))).thenReturn(nil)
        }
        
        Cuckoo.stub(mockRule2) { mock in
            when(mock.match(with: state(equalTo: mockState))).thenReturn([genericAction])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRule1).match(with: state(equalTo: mockState))
        verify(mockRule2).match(with: state(equalTo: mockState))
        let argumentCaptor = ArgumentCaptor<[GenericAction]>()
        verify(mockState).setActions(argumentCaptor.capture())
        XCTAssertEqual(argumentCaptor.value?.count, 1)
        XCTAssertEqual(argumentCaptor.value?[0].actorId, "p1")
        XCTAssertEqual(argumentCaptor.value?[0].name, "ac")
        XCTAssertEqual(argumentCaptor.value?[0].options.map { $0.description }, ["a1", "a2"])
    }
    
    func test_DoNotGenerateActions_IfGameIsOver() {
        // Given
        let mockAction = MockActionProtocol().withEnabledDefaultImplementation(ActionProtocolStub())
        Cuckoo.stub(mockState) { mock in
            when(mock.outcome.get).thenReturn(.sheriffWin)
        }
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockAction).execute(in: state(equalTo: mockState))
        verify(mockState).setActions(isEmpty())
        verifyNoMoreInteractions(mockRule1)
        verifyNoMoreInteractions(mockRule2)
    }
}
