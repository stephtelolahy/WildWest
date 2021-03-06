//
//  MockCardProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockCardProtocol {
    
    func identified(by identifier: String) -> MockCardProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.identifier.get).thenReturn(identifier)
        }
        return self
    }
    
    func named(_ name: CardName) -> MockCardProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.name.get).thenReturn(name)
        }
        return self
    }
    
    func suit(is suit: CardSuit) -> MockCardProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.suit.get).thenReturn(suit)
        }
        return self
    }
    
    func value(is value: String) -> MockCardProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.value.get).thenReturn(value)
        }
        return self
    }
}
