//
//  EngineTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 28/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo
import RxSwift

class EngineTests: XCTestCase {
    
    private var sut: EngineProtocol!
    private var mockLoop: MockGLoopProtocol!
    
    override func setUp() {
        mockLoop = MockGLoopProtocol().withEnabledDefaultImplementation(GLoopProtocolStub())
        stub(mockLoop) { mock in
            when(mock.run(any())).thenReturn(Completable.empty())
        }
        sut = GEngine(loop: mockLoop)
    }
    
    func test_RunLoopWithoutMove_IfRefreshing() {
        // Given
        // When
        sut.refresh()
        
        // Assert
        verify(mockLoop).run(isNil())
    }
    
    func test_RunLoop_IfExecutingMove() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        
        // When
        sut.execute(move1)
        
        // Assert
        verify(mockLoop).run(equal(to: move1))
    }
    
    func test_DoNothing_IfAlreadyExecuting() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        let move2 = GMove("m2", actor: "p1")
        let move3 = GMove("m3", actor: "p1")
        stub(mockLoop) { mock in
            when(mock.run(any())).then { _ in
                Completable.empty().delay(.milliseconds(1), scheduler: MainScheduler.instance)
            }
        }
        
        // When
        sut.execute(move1)
        sut.execute(move2)
        sut.execute(move3)
        
        // Assert
        verify(mockLoop).run(equal(to: move1))
        verify(mockLoop, never()).run(equal(to: move2))
        verify(mockLoop, never()).run(equal(to: move3))
    }
}
