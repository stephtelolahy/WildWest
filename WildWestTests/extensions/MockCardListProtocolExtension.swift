//
//  MockCardListProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockCardListProtocol {
    func containing(_ cards: CardProtocol...) -> MockCardListProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.cards.get).thenReturn(cards)
        }
        return self
    }
}
