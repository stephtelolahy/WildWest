//
//  CuckooExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import Cuckoo

func identified(by identifier: String) -> ParameterMatcher<CardProtocol> {
    return ParameterMatcher { tested in
        return tested.identifier == identifier
    }
}

extension MockCardProtocol {
    func identified(by identifier: String) -> MockCardProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.identifier.get).thenReturn(identifier)
        }
        return self
    }
}

extension MockCardListProtocol {
    func containing(_ cards: [CardProtocol]) -> MockCardListProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.cards.get).thenReturn(cards)
        }
        return self
    }
}
