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
    
    override func setUp() {
        mockState = MockGameStateProtocol()
        engine = GameEngine()
    }
    
}
