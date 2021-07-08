//
//  SimulationTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 23/01/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length

import XCTest
import WildWestEngine
import RxSwift

class SimulationTests: XCTestCase {
    
    private var engine: EngineProtocol!
    private var database: DatabaseProtocol!
    private var agents: [AIAgentProtocol]!
    private var disposeBag: DisposeBag!
    
    func test_Simulate4PlayersGame() {
        // Given
        // When
        let expectation = XCTestExpectation(description: "Game should complete")
        runSimulation(playersCount: 4) {
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_Simulate5PlayersGame() {
        // Given
        // When
        let expectation = XCTestExpectation(description: "Game should complete")
        runSimulation(playersCount: 5) {
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_Simulate6PlayersGame() {
        // Given
        // When
        let expectation = XCTestExpectation(description: "Game should complete")
        runSimulation(playersCount: 6) {
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    private func runSimulation(playersCount: Int, completed: @escaping () -> Void) {
        let jsonReader = JsonReader(bundle: Bundle.resourcesBundle)
        let resourcesLoader = ResourcesLoader(jsonReader: jsonReader)
        let cards = resourcesLoader.loadCards()
        let cardSet = resourcesLoader.loadDeck()
        let abilities = resourcesLoader.loadAbilities()
        
        let setup = GSetup()
        let roles = setup.roles(for: playersCount)
        let state = setup.setupGame(roles: roles,
                                    cards: cards,
                                    cardSet: cardSet,
                                    preferredRole: nil,
                                    preferredFigure: nil)
        let databaseUpdater = GDatabaseUpdater()
        let database = GDatabase(state, updater: databaseUpdater)
        
        let abilityMatcher = AbilityMatcher(abilities)
        let eventsQueue = GEventQueue()
        let eventMatcher = LinearDurationMatcher()
        let timer = GTimer(matcher: eventMatcher)
        let loop = GLoop(eventsQueue: eventsQueue,
                         database: database,
                         matcher: abilityMatcher,
                         timer: timer)
        let engine = GEngine(loop: loop)
        
        let sheriff = state.players.values.first(where: { $0.role == .sheriff })!.identifier
        let agents: [AIAgentProtocol] = state.playOrder.map { player in
            let abilityEvaluator = AbilityEvaluator()
            let roleEstimator = RoleEstimator(sheriff: sheriff, abilityEvaluator: abilityEvaluator)
            let roleStrategy = RoleStrategy()
            let moveEvaluator = MoveEvaluator(abilityEvaluator: abilityEvaluator, roleEstimator: roleEstimator, roleStrategy: roleStrategy)
            let ai = RandomWithRoleAi(moveEvaluator: moveEvaluator)
            return AIAgent(player: player, engine: engine, ai: ai)
        }
        
        let segmenter = MoveSegmenter()
        let selector = MoveSelector()
        
        var eventId = 0
        let disposeBag = DisposeBag()
        
        database.event.subscribe(onNext: { event in
            eventId += 1
            print("[E\(eventId)/\(playersCount)]: \(event)")
            if case .gameover = event {
                completed()
            }
            
            if case let .activate(moves) = event {
                // Assert active moves not empty
                XCTAssertFalse(moves.isEmpty)
                
                // Assert one active player at a time
                XCTAssertTrue(moves.allSatisfy { $0.actor == moves[0].actor })
                
                // Assert each segmented moves can be selected
                segmenter.segment(moves).values
                    .forEach { _ = selector.select($0, suggestedTitle: nil) }
            }
        })
        .disposed(by: disposeBag)
        
        database.state.subscribe(onNext: { state in
            print("[S]: \(state)")
        })
        .disposed(by: disposeBag)
        
        agents.forEach { $0.observe(database) }
        engine.refresh()
        
        self.disposeBag = disposeBag
        self.agents = agents
        self.database = database
        self.engine = engine
    }
}

private class LinearDurationMatcher: EventDurationProtocol {
    func waitDuration(_ event: GEvent) -> TimeInterval {
        0
    }
}
