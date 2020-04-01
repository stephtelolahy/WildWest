//
//  Figure.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Figure: FigureProtocol, Equatable {
    let name: FigureName
    let bullets: Int
    let imageName: String
    let description: String
    let abilities: [AbilityName: Bool]
}
