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
        let result = withEnabledDefaultImplementation(CardProtocolStub())
        Cuckoo.stub(result) { mock in
            let mockAttributes = MockCardAttributesProtocol().withEnabledDefaultImplementation(CardAttributesProtocolStub())
            when(mock.attributes.get).thenReturn(mockAttributes)
        }
        return result
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
    
    func abilities(are values: String...) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.abilities.get).thenReturn(Set(values))
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
    
    func attributes(is value: CardAttributesProtocol) -> MockCardProtocol {
        stub(self) { mock in
            when(mock.attributes.get).thenReturn(value)
        }
        return self
    }
}
