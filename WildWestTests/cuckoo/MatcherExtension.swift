//
//  MatcherExtension.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

func card(equalTo object: AnyObject) -> ParameterMatcher<CardProtocol> {
    return ParameterMatcher(matchesFunction: { card -> Bool in
        return card as AnyObject === object
    })
}

func state(equalTo object: AnyObject) -> ParameterMatcher<GameStateProtocol> {
    return ParameterMatcher(matchesFunction: { state -> Bool in
        return state as AnyObject === object
    })
}

func mutableState(equalTo object: AnyObject) -> ParameterMatcher<MutableGameStateProtocol> {
    return ParameterMatcher(matchesFunction: { state -> Bool in
        return state as AnyObject === object
    })
}

func action(equalTo object: AnyObject) -> ParameterMatcher<ActionProtocol> {
    return ParameterMatcher(matchesFunction: { action -> Bool in
        return action as AnyObject === object
    })
}

func actions(equalTo array: [AnyObject]) -> ParameterMatcher<[ActionProtocol]> {
    return ParameterMatcher(matchesFunction: { actions -> Bool in
        for (index, element) in actions.enumerated() {
            guard element as AnyObject === array[index] else {
                return false
            }
        }
        
        return true
    })
}

func player(equalTo object: AnyObject) -> ParameterMatcher<PlayerProtocol> {
    return ParameterMatcher(matchesFunction: { player -> Bool in
        return player as AnyObject === object
    })
}

func isEmpty<T>() -> ParameterMatcher<[T]> {
    return ParameterMatcher(matchesFunction: { value -> Bool in
        return value.isEmpty
    })
}
