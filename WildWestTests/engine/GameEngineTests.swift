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
        Cuckoo.stub(mockRule1) { mock in
            when(mock.actionName.get).thenReturn("n1")
            when(mock.match(with: state(equalTo: mockState))).thenReturn([action1])
        }
        Cuckoo.stub(mockRule2) { mock in
            when(mock.actionName.get).thenReturn("n2")
            when(mock.match(with: state(equalTo: mockState))).thenReturn([action2])
        }
        
        // When
        sut.execute(mockAction)
        
        // Assert
        verify(mockRule1).match(with: state(equalTo: mockState))
        verify(mockRule2).match(with: state(equalTo: mockState))
        
        let argumentCaptor = ArgumentCaptor<[GenericAction]>()
        verify(mockPlayer1).setActions(argumentCaptor.capture())
        XCTAssertEqual(argumentCaptor.value?.count, 2)
        XCTAssertEqual(argumentCaptor.value?[0].name, "n1")
        XCTAssertEqual(argumentCaptor.value?[0].options.map { $0.description }, ["a1"])
        XCTAssertEqual(argumentCaptor.value?[1].name, "n2")
        XCTAssertEqual(argumentCaptor.value?[1].options.map { $0.description }, ["a2"])
        verify(mockPlayer2).setActions(isEmpty())
    }
}
