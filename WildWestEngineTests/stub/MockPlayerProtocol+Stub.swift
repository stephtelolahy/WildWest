//
//  MockPlayerProtocol+Stub.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import WildWestEngine
import Cuckoo

extension MockPlayerProtocol {
    
    func withDefault() -> MockPlayerProtocol {
        withEnabledDefaultImplementation(PlayerProtocolStub())
    }
    
    func identified(by identifier: String) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.identifier.get).thenReturn(identifier)
        }
        return self
    }
    
    func health(is health: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.health.get).thenReturn(health)
        }
        return self
    }
    
    func maxHealth(is maxHealth: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.maxHealth.get).thenReturn(maxHealth)
        }
        return self
    }
    
    func holding(_ cards: CardProtocol...) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.hand.get).thenReturn(cards)
        }
        return self
    }
    
    func playing(_ cards: CardProtocol...) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.inPlay.get).thenReturn(cards)
        }
        return self
    }
    
    func abilities(are values: String...) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.abilities.get).thenReturn(Set(values))
        }
        return self
    }
    
    func weapon(is weapon: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.weapon.get).thenReturn(weapon)
        }
        return self
    }
    
    func bangsPerTurn(is limit: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.bangsPerTurn.get).thenReturn(limit)
        }
        return self
    }
    
    func bangsCancelable(is value: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.bangsCancelable.get).thenReturn(value)
        }
        return self
    }

    func flippedCards(is value: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.flippedCards.get).thenReturn(value)
        }
        return self
    }

    func handLimit(is value: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.handLimit.get).thenReturn(value)
        }
        return self
    }

    func role(is role: Role) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.role.get).thenReturn(role)
        }
        return self
    }
    
    func scope(is value: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.scope.get).thenReturn(value)
        }
        return self
    }
    
    func mustang(is value: Int) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.mustang.get).thenReturn(value)
        }
        return self
    }
    
    func attributes(are value: [CardAttributeKey: Any]) -> MockPlayerProtocol {
        stub(self) { mock in
            when(mock.attributes.get).thenReturn(value)
        }
        return self
    }
}
