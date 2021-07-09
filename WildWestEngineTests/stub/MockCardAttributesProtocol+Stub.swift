//
//  MockCardAttributesProtocol+Stub.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 09/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
import WildWestEngine
import Cuckoo

extension MockCardAttributesProtocol {
    
    func withDefault() -> MockCardAttributesProtocol {
        withEnabledDefaultImplementation(CardAttributesProtocolStub())
    }
    
    func bullets(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.bullets.get).thenReturn(value)
        }
        return self
    }
    
    func mustang(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.mustang.get).thenReturn(value)
        }
        return self
    }
    
    func scope(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.scope.get).thenReturn(value)
        }
        return self
    }
    
    func weapon(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.weapon.get).thenReturn(value)
        }
        return self
    }
    
    func flippedCards(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.flippedCards.get).thenReturn(value)
        }
        return self
    }
    
    func bangsPerTurn(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.bangsPerTurn.get).thenReturn(value)
        }
        return self
    }
    
    func bangsCancelable(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.bangsCancelable.get).thenReturn(value)
        }
        return self
    }
    
    func handLimit(is value: Int) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.handLimit.get).thenReturn(value)
        }
        return self
    }
    
    func silentCard(is value: String) -> MockCardAttributesProtocol {
        stub(self) { mock in
            when(mock.silentCard.get).thenReturn(value)
        }
        return self
    }
}
