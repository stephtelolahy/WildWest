//
//  MockPlayerProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/21/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockPlayerProtocol {
    
    func identified(by identifier: String) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.identifier.get).thenReturn(identifier)
        }
        return self
    }
    
    func role(is role: Role) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.role.get).thenReturn(role)
        }
        return self
    }
    
    func health(is health: Int) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.health.get).thenReturn(health)
        }
        return self
    }
    
    func maxHealth(is maxHealth: Int) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.maxHealth.get).thenReturn(maxHealth)
        }
        return self
    }
    
    func holding(_ cards: CardProtocol...) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.hand.get).thenReturn(cards)
        }
        return self
    }
    
    func noCardsInHand() -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.hand.get).thenReturn([])
        }
        return self
    }
    
    func playing(_ cards: CardProtocol...) -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.inPlay.get).thenReturn(cards)
        }
        return self
    }
    
    func noCardsInPlay() -> MockPlayerProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.inPlay.get).thenReturn([])
        }
        return self
    }
    
    func withDefault() -> MockPlayerProtocol {
        let defaultFigure = Figure(name: .bartCassidy, bullets: 4, imageName: "", description: "", abilities: [:])
        Cuckoo.stub(self) { mock in
            when(mock.figure.get).thenReturn(defaultFigure)
        }
        return self.withEnabledDefaultImplementation(PlayerProtocolStub())
    }
    
    func abilities(are dictionary: [AbilityName: Bool]) -> MockPlayerProtocol {
        let figure = Figure(name: .bartCassidy, bullets: 4, imageName: "", description: "", abilities: dictionary)
        Cuckoo.stub(self) { mock in
            when(mock.figure.get).thenReturn(figure)
        }
        return self
    }
}
