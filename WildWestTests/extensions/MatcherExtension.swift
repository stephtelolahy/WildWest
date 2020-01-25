//
//  MatcherExtension.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Cuckoo

func identified(by identifier: String) -> ParameterMatcher<CardProtocol> {
    return ParameterMatcher(matchesFunction: { card -> Bool in
        return card.identifier == identifier
    })
}

func identified(by identifiers: [String]) -> ParameterMatcher<[CardProtocol]> {
    return ParameterMatcher(matchesFunction: { cards -> Bool in
        return cards.map { $0.identifier } == identifiers
    })
}
