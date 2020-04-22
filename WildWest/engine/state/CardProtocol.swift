//
//  CardProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol CardProtocol {
    var identifier: String { get }
    var name: CardName { get }
    var value: String { get }
    var suit: CardSuit { get }
    var imageName: String { get }
}

enum CardName: String, Codable {
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
    bang,
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

enum CardSuit: String, Codable {
    case spades,
    hearts,
    diamonds,
    clubs
}
