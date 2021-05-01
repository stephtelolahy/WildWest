//
//  MatcherExtension.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 28/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Cuckoo
import WildWestEngine

func state(equalTo object: AnyObject) -> ParameterMatcher<StateProtocol> {
    ParameterMatcher { state in
        state as AnyObject === object
    }
}
