//
//  MCTSAiTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 18/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class MCTSAiTests: XCTestCase {

    private var sut: MCTSAi!
    private let resourcesLoader: ResourcesLoaderProtocol = Resolver.resolve()
    private let abilityMatcher: AbilityMatcherProtocol = Resolver.resolve()
    
    override func setUp() {
        sut = MCTSAi(matcher: abilityMatcher)
        
        #warning("TODO: fix static reference")
        GState.matcher = abilityMatcher
    }

    func test_GivenInitialGame_whenSimulateAIPlay_thenGameComplete() {
        let setup = GSetup()
        let roles = setup.roles(for: 2)
        let cards = resourcesLoader.loadCards()
        let cardSet = resourcesLoader.loadDeck()
        
        var state: GState = GSetup().setupGame(roles: roles, cards: cards, cardSet: cardSet, preferredRole: nil, preferredFigure: nil) as! GState
        
        let loop = SyncGameLoop(matcher: abilityMatcher, databaseUpdater: GDatabaseUpdater())
        state = loop.performMove(nil, in: state) as! GState
        
        while state.status == MCTS.Status.inProgress {
            let bestMove = sut.bestMove(among: [], in: state)
            state = state.performMove(bestMove)
            print("[S]: \(state.players.map({ "\($0.value.name.prefix(5))|x\($0.value.health)|[]\($0.value.hand.count)" }).joined(separator: " - ")) : \(bestMove.ability)")
        }
        
        XCTAssertEqual(state.status, 1)
    }

}
