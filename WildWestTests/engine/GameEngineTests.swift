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
    private var mockRenderer: MockGameRendererProtocol!
    private var mockRules: MockGameRulesProtocol!
    private var mockAI: MockGameAIProtocol!
    
    override func setUp() {
        mockState = MockGameStateProtocol()
        mockRules = MockGameRulesProtocol()
        mockAI = MockGameAIProtocol()
        mockRenderer = MockGameRendererProtocol()
        engine = GameEngine(state: mockState,
                            rules: mockRules,
                            aiPlayer: mockAI,
                            renderer: mockRenderer)
    }
    
    func test_DoNothing_IfGameIsOver() {
        let game = Game(players: [], deck: [], discard: [])
        Cuckoo.stub(mockState) { mock in when(mock.game.get).thenReturn(game) }
        Cuckoo.stub(mockRules) { mock in when(mock.isOver(any())).thenReturn(true) }
        
        engine.run()
        
        verifyNoMoreInteractions(mockRenderer)
        verifyNoMoreInteractions(mockAI)
    }
    
    func test_LoopUntilGameIsOver() {
        let game = Game(players: [], deck: [], discard: [])
        let mockAction = MockGameAction()
        let mockUpdate = MockGameUpdate()
        Cuckoo.stub(mockState) { mock in
            when(mock.game.get).thenReturn(game)
            when(mock.game.set(any())).thenDoNothing()
        }
        Cuckoo.stub(mockRules) { mock in
            when(mock.isOver(any())).thenReturn(false, true)
            when(mock.possibleActions(any())).thenReturn([mockAction])
        }
        Cuckoo.stub(mockAI) { mock in when(mock.choose(any())).thenReturn(mockAction) }
        Cuckoo.stub(mockRenderer) { mock in when(mock.render(any())).thenDoNothing() }
        Cuckoo.stub(mockAction) { mock in when(mock.execute(any())).thenReturn([mockUpdate]) }
        Cuckoo.stub(mockUpdate) { mock in when(mock.apply(to: any())).thenReturn(game) }
        
        engine.run()
        
        verify(mockState).game.set(any())
        verify(mockRenderer).render(any())
    }
    
}
