//
//  FigureDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct FigureDto: Codable {
    let name: FigureName
    let bullets: Int
    let imageName: String
    let description: String
    let abilities: [AbilityName: Bool]?
}
