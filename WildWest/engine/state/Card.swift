//
//  Card.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/9/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol CardProtocol {
    var identifier: String { get }
    var name: CardName { get }
    var type: CardType { get }
    var suits: CardSuit { get }
    var value: String { get }
}

enum CardName {
    case colt45,
    volcanic,
    schofield,
    remington,
    winchester,
    revCarbine,
    barrel,
    mustang,
    scope,
    dynamite,
    jail,
    shoot,
    missed,
    duel,
    gatling,
    indians,
    panic,
    catBalou,
    beer,
    saloon,
    stagecoach,
    wellsFargo,
    generalStore
}

enum CardType {
    case gun,
    item,
    play
}

enum CardSuit {
    case spades,
    hearts,
    diamonds,
    clubs
}
