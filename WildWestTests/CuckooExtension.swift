//
//  CuckooExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import Cuckoo

func identified(by identifier: String) -> ParameterMatcher<Card> {
    return ParameterMatcher { tested in
        return tested.identifier == identifier
    }
}
