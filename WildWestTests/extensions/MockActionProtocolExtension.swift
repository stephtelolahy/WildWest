//
//  MockActionProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockActionProtocol {
    func described(by description: String) -> MockActionProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.description.get).thenReturn(description)
        }
        return self
    }
}
