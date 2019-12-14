//
//  DiscardTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class DiscardTests: XCTestCase {
    
    func test_Discard() {
        /*
        let card = Card(identifier: "c1", name: .beer, type: .play, suits: .clubs, value: "5")
        
        let mockState = MockGameStateProtocol()
        let mockPlayer = MockPlayerProtocol()
        Cuckoo.stub(mockState) { mock in when(mock.discard.cards.get).thenReturn([]) }
        Cuckoo.stub(mockState) { mock in when(mock.players.get).thenReturn([mockPlayer]) }
        Cuckoo.stub(mockPlayer) { mock in
            when(mock.hand.get).thenReturn([card])
            when(mock.identifier.get).thenReturn("p1")
        }
        
        let action = Discard(playerIdentifier: "p1", cardIdentifier: "c1")
        
        action.apply(to: mockState)
        
        verify(mockState).discard.set(equal(to: [card]))
        verify(mockPlayer).hand.set(equal(to: []))
 */
    }

}
