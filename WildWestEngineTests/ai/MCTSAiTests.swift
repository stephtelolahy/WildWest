//
//  MCTSAiTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 18/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_cast

import XCTest
import WildWestEngine
import Resolver

class MCTSAiTests: XCTestCase {

    private var sut: MCTSAi!
    private let resourcesLoader: ResourcesLoaderProtocol = Resolver.resolve()
    private let rules: GameRulesProtocol = Resolver.resolve()
    
    override func setUp() {
        sut = MCTSAi(rules: rules)
    }
    
    func test_GivenInitialGame_whenSimulateAIPlay_thenGameComplete() {
        let setup = GSetup()
        let roles = setup.roles(for: 2)
        let cards = resourcesLoader.loadCards()
        let cardSet = resourcesLoader.loadDeck()
        
        var state: GState = GSetup().setupGame(roles: roles, cards: cards, cardSet: cardSet, preferredRole: nil, preferredFigure: nil) as! GState
        
        let loop = GEngineSyncronous(rules: rules, databaseUpdater: GDatabaseUpdater())
        state = loop.run(nil, in: state) as! GState
        
        while state.status == MCTS.Status.inProgress {
            let move = sut.bestMove(among: [], in: state)
            state = state.performMove(move)
            print("[S]: \(state.debugDescription) : \(move.ability)")
        }
        
        XCTAssertNotNil(state.winner)
    }
}

private extension StateProtocol {
    
    var debugDescription: String {
        players
            .map({ "\($0.value.name.prefix(5))|x\($0.value.health)|[]\($0.value.hand.count)" })
            .joined(separator: " - ")
    }
}
