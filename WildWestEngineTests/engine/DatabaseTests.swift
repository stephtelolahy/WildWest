//
//  DatabaseTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import RxSwift
import RxTest
import Cuckoo
import WildWestEngine

class DatabaseTests: XCTestCase {
    
    private var sut: DatabaseProtocol!
    private var mockUpdater: MockGDatabaseUpdaterProtocol!
    private var eventObserver: TestableObserver<GEvent>!
    private var stateObserver: TestableObserver<StateProtocol>!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        mockUpdater = MockGDatabaseUpdaterProtocol().withEnabledDefaultImplementation(GDatabaseUpdaterProtocolStub())
        sut = GDatabase(MockStateProtocol().withDefault(), updater: mockUpdater)
        
        disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        
        eventObserver = scheduler.createObserver(GEvent.self)
        sut.event.subscribe(eventObserver).disposed(by: disposeBag)
        
        stateObserver = scheduler.createObserver(StateProtocol.self)
        sut.state.subscribe(stateObserver).disposed(by: disposeBag)
    }
    
    // MARK: - Initial values
    
    func test_InitialValues() throws {
        // Given
        // When
        // Assert
        XCTAssertEqual(eventObserver.events.count, 0)
        XCTAssertEqual(stateObserver.events.count, 1)
        
        let state = try XCTUnwrap(stateObserver.events.last?.value.element)
        XCTAssertNotNil(state)
    }
    
    // MARK: - applyEvent
    
    func test_EmitSameEvent_IfApplyingEvent() throws {
        // Given
        let event = GEvent.deckToStore
        
        // When
        sut.update(event: event).subscribe().disposed(by: disposeBag)
        
        // Assert
        XCTAssertEqual(eventObserver.events.count, 1)
        let emitedEvent = try XCTUnwrap(eventObserver.events.last?.value.element)
        XCTAssertEqual(emitedEvent, event)
    }
    
    func test_EmitState_IfApplyingEvent() throws {
        // Given
        let event = GEvent.deckToStore
        
        // When
        sut.update(event: event).subscribe().disposed(by: disposeBag)
        
        // Assert
        XCTAssertEqual(stateObserver.events.count, 2)
    }
    
    func test_ExecuteEventFunction_IfApplyingEvent() throws {
        // Given
        let event = GEvent.deckToStore
        
        // When
        sut.update(event: event).subscribe().disposed(by: disposeBag)
        
        // Assert
        verify(mockUpdater).execute(equal(to: event), in: any())
    }
    
    // MARK: - RestrictedDatabaseProtocol
    
    func test_HideRoleDependingOnObserver() throws {
        // Given
        let scheduler = TestScheduler(initialClock: 0)
        let stateObserver0 = scheduler.createObserver(StateProtocol.self)
        let stateObserver1 = scheduler.createObserver(StateProtocol.self)
        let stateObserver2 = scheduler.createObserver(StateProtocol.self)
        
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .outlaw)
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3").role(is: .deputy)
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4").role(is: .renegade)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
            .playOrder(is: "p1", "p2", "p3")
        sut = GDatabase(mockState, updater: mockUpdater)
        
        // When
        sut.state(observedBy: nil).subscribe(stateObserver0).disposed(by: disposeBag)
        sut.state(observedBy: "p1").subscribe(stateObserver1).disposed(by: disposeBag)
        sut.state(observedBy: "p2").subscribe(stateObserver2).disposed(by: disposeBag)
        
        // Assert
        XCTAssertEqual(stateObserver0.events.count, 1)
        let state0 = try XCTUnwrap(stateObserver0.events.last?.value.element)
        XCTAssertEqual(state0.players["p1"]!.role, .sheriff)
        XCTAssertNil(state0.players["p2"]!.role)
        XCTAssertNil(state0.players["p3"]!.role)
        XCTAssertEqual(state0.players["p4"]!.role, .renegade)
        
        XCTAssertEqual(stateObserver1.events.count, 1)
        let state1 = try XCTUnwrap(stateObserver1.events.last?.value.element)
        XCTAssertEqual(state1.players["p1"]!.role, .sheriff)
        XCTAssertNil(state1.players["p2"]!.role)
        XCTAssertNil(state1.players["p3"]!.role)
        XCTAssertEqual(state1.players["p4"]!.role, .renegade)
        
        XCTAssertEqual(stateObserver2.events.count, 1)
        let state2 = try XCTUnwrap(stateObserver2.events.last?.value.element)
        XCTAssertEqual(state2.players["p1"]!.role, .sheriff)
        XCTAssertEqual(state2.players["p2"]!.role, .outlaw)
        XCTAssertNil(state2.players["p3"]!.role)
        XCTAssertEqual(state2.players["p4"]!.role, .renegade)
    }
    
    func test_EnumeratePlayersDependingOnObserver() throws {
        // Given
        let scheduler = TestScheduler(initialClock: 0)
        let stateObserver0 = scheduler.createObserver(StateProtocol.self)
        let stateObserver1 = scheduler.createObserver(StateProtocol.self)
        let stateObserver2 = scheduler.createObserver(StateProtocol.self)
        let stateObserver3 = scheduler.createObserver(StateProtocol.self)
        
        let mockPlayer1 = MockPlayerProtocol().withDefault().identified(by: "p1").role(is: .sheriff)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2").role(is: .outlaw)
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3").role(is: .deputy)
        let mockPlayer4 = MockPlayerProtocol().withDefault().identified(by: "p4").role(is: .renegade)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
            .initialOrder(is: "p1", "p2", "p3", "p4")
        sut = GDatabase(mockState, updater: mockUpdater)
        
        // When
        sut.state(observedBy: nil).subscribe(stateObserver0).disposed(by: disposeBag)
        sut.state(observedBy: "p1").subscribe(stateObserver1).disposed(by: disposeBag)
        sut.state(observedBy: "p2").subscribe(stateObserver2).disposed(by: disposeBag)
        sut.state(observedBy: "p3").subscribe(stateObserver3).disposed(by: disposeBag)
        
        // Assert
        XCTAssertEqual(stateObserver0.events.count, 1)
        let state0 = try XCTUnwrap(stateObserver0.events.last?.value.element)
        XCTAssertEqual(state0.initialOrder, ["p1", "p2", "p3", "p4"])
        
        XCTAssertEqual(stateObserver1.events.count, 1)
        let state1 = try XCTUnwrap(stateObserver1.events.last?.value.element)
        XCTAssertEqual(state1.initialOrder, ["p1", "p2", "p3", "p4"])
        
        XCTAssertEqual(stateObserver2.events.count, 1)
        let state2 = try XCTUnwrap(stateObserver2.events.last?.value.element)
        XCTAssertEqual(state2.initialOrder, ["p2", "p3", "p4", "p1"])
        
        XCTAssertEqual(stateObserver3.events.count, 1)
        let state3 = try XCTUnwrap(stateObserver3.events.last?.value.element)
        XCTAssertEqual(state3.initialOrder, ["p3", "p4", "p1", "p2"])
    }
}
