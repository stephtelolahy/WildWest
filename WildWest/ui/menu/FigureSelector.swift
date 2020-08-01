//
//  FigureSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import Resolver

class FigureSelector: UIAlertController {
    
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    private lazy var gameResources: GameResourcesProtocol = Resolver.resolve()
    
    convenience init(completion: @escaping (FigureName?) -> Void) {
        self.init(title: "Choose figure", message: nil, preferredStyle: .alert)
        let figures = gameResources.allFigures.map { $0.name }
        figures.forEach { figure in
            addAction(UIAlertAction(title: figure.rawValue,
                                    style: .default,
                                    handler: { _ in
                                        self.preferences.preferredFigure = figure
                                        completion(figure)
                                        
            }))
        }
        
        addAction(UIAlertAction(title: "Random",
                                style: .cancel,
                                handler: { _ in
                                    self.preferences.preferredFigure = nil
                                    completion(nil)
        }))
    }
}
