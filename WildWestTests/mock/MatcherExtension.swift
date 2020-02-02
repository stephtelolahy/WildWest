//
//  MatcherExtension.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

func card(identifiedBy identifier: String) -> ParameterMatcher<CardProtocol> {
    return ParameterMatcher(matchesFunction: { card -> Bool in
        return card.identifier == identifier
    })
}

func cards(identifiedBy identifiers: [String]) -> ParameterMatcher<[CardProtocol]> {
    return ParameterMatcher(matchesFunction: { cards -> Bool in
        return cards.map { $0.identifier } == identifiers
    })
}

func action(describedBy description: String) -> ParameterMatcher<ActionProtocol> {
    return ParameterMatcher(matchesFunction: { action -> Bool in
        return action.description == description
    })
}

func state(equalTo object: AnyObject) -> ParameterMatcher<GameStateProtocol> {
    return ParameterMatcher(matchesFunction: { state -> Bool in
        return state as AnyObject === object
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
