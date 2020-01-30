//
//  CardListProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol CardListProtocol {
    var cards: [CardProtocol] { get }
    
    func add(_ card: CardProtocol)
    func addAll(_ cards: [CardProtocol])
    func removeFirst() -> CardProtocol?
    func removeById(_ identifier: String) -> CardProtocol?
    func removeAll() -> [CardProtocol]
}
