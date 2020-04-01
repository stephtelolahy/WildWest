//
//  MockFigureProtocolExtension.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

extension MockFigureProtocol {
    func named(_ value: FigureName) -> MockFigureProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.name.get).thenReturn(value)
        }
        return self
    }
    
    func bullets(is value: Int) -> MockFigureProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.bullets.get).thenReturn(value)
        }
        return self
    }
    
    func imageName(is value: String) -> MockFigureProtocol {
        Cuckoo.stub(self) { mock in
            when(mock.imageName.get).thenReturn(value)
        }
        return self
    }
}

