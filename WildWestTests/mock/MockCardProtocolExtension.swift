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
}
