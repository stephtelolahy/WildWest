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
    let abilities: [String: Bool]?
}

class FigureMapper {
    
    func map(dto: FigureDto) -> Figure {
        let abilitiesDto = dto.abilities ?? [:]
        var abilitities: [AbilityName: Bool] = [:]
        abilitiesDto.forEach { key, value in
            if let name = AbilityName(rawValue: key) {
                abilitities[name] = value
            }
        }
        
        return Figure(name: dto.name,
                      bullets: dto.bullets,
                      imageName: dto.imageName,
                      description: dto.description,
                      abilities: abilitities)
    }
}
