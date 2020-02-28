//
//  MockActionProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockActionProtocol {
    
    func autoPlay(is value: Bool) -> MockActionProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.autoPlay.get).thenReturn(value)
        }
        return self
    }
}
