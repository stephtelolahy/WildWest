//
//  GameEngineTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameEngineTests: XCTestCase {
    
    private var engine: GameEngineProtocol!
    
    private var mockState: MockGameStateProtocol!
    private var mockRules: MockGameRulesProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol()
        mockRules = MockGameRulesProtocol()
        engine = GameEngine(state: mockState,
                            rules: mockRules)
    }
    
    func test_DoNothing_IfGameIsOver() {
        Cuckoo.stub(mockState) { mock in when(mock.outcome.get).thenReturn(.outlawWin) }
        
        engine.run()
        
        verifyNoMoreInteractions(mockRules)
    }
    
    func test_LoopUntilGameIsOver() {
        let mockAction = MockGameActionProtocol()
        let mockUpdate = MockGameUpdateProtocol()
        Cuckoo.stub(mockState) { mock in when(mock.outcome.get).thenReturn(nil, .outlawWin) }
        Cuckoo.stub(mockRules) { mock in when(mock.possibleActions(any())).thenReturn([mockAction]) }
        Cuckoo.stub(mockAction) { mock in when(mock.execute()).thenReturn([mockUpdate]) }
        Cuckoo.stub(mockUpdate) { mock in when(mock.apply(to: any())).thenDoNothing() }
        
        engine.run()
        
        verify(mockRules).possibleActions(any())
        verify(mockAction).execute()
        verify(mockUpdate).apply(to: any())
    }
    
}
