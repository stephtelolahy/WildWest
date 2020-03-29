//
//  FigureProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol FigureProtocol {
    var ability: Ability { get }
    var bullets: Int { get }
    var imageName: String { get }
    var description: String { get }
}
