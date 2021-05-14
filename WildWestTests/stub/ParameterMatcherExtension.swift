//
//  ParameterMatcherExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 14/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Cuckoo

func any<T: Equatable>(equalTo value: T) -> ParameterMatcher<Any?> {
    ParameterMatcher { object in
        object as? T == value
    }
}
