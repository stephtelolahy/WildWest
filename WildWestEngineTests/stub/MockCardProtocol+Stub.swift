//
//  MockCardProtocol+Stub.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import WildWestEngine
import Cuckoo

extension MockCardProtocol {
    
    func withDefault() -> MockCardProtocol {
        withEnabledDefaultImplementation(CardProtocolStub())
    }
    
    func identified(by identifier: String) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.identifier.get).thenReturn(identifier)
        }
        return self
    }
    
    func named(_ name: String) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.name.get).thenReturn(name)
        }
        return self
    }
    
    func type(is cardType: CardType) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.type.get).thenReturn(cardType)
        }
        return self
    }
    
    func abilities(are abilities: String...) -> MockCardProtocol {
        stub(self) { mock in
            let dict: [String: Int] = abilities.reduce([:]) { dict, ability in
                var dict = dict
                dict[ability] = 0
                return dict
            }
            when(mock.abilities.get).thenReturn(dict)
        }
        return self
    }

    func abilities(are abilities: [String: Int]) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.abilities.get).thenReturn(abilities)
        }
        return self
    }

    func suit(is suit: String) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.suit.get).thenReturn(suit)
        }
        return self
    }

    func value(is value: String) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.value.get).thenReturn(value)
        }
        return self
    }
}