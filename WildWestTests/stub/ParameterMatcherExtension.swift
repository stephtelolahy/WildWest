//
//  ParameterMatcherExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 14/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Cuckoo

func any(equalToString string: String) -> ParameterMatcher<Any?> {
    ParameterMatcher { object in
        object as? String == string
    }
}

func any(equalToInt integer: Int) -> ParameterMatcher<Any?> {
    ParameterMatcher { object in
        object as? Int == integer
    }
}

func any(equalToStringArray array: [String]) -> ParameterMatcher<Any?> {
    ParameterMatcher { object in
        object as? [String] == array
    }
}
