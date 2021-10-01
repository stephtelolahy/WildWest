//
//  MockHitProtocol+Stub.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 04/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import WildWestEngine
import Cuckoo

extension MockHitProtocol {
    
    func withDefault() -> MockHitProtocol {
        withEnabledDefaultImplementation(HitProtocolStub())
    }
    
    func named(_ name: String) -> MockHitProtocol {
        stub(self) { mock in
            when(mock.name.get).thenReturn(name)
        }
        return self
    }
    
    func players(are players: String...) -> MockHitProtocol {
        stub(self) { mock in
            when(mock.players.get).thenReturn(players)
        }
        return self
    }
    
    func abilities(are abilities: String...) -> MockHitProtocol {
        stub(self) { mock in
            when(mock.abilities.get).thenReturn(abilities)
        }
        return self
    }
    
    func cancelable(is cancelable: Int) -> MockHitProtocol {
        stub(self) { mock in
            when(mock.cancelable.get).thenReturn(cancelable)
        }
        return self
    }
    
    func targets(are targets: String...) -> MockHitProtocol {
        stub(self) { mock in
            when(mock.targets.get).thenReturn(targets)
        }
        return self
    }
}
