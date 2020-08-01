//
//  FigureSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class FigureSelector: UIAlertController {
    
    private lazy var preferences = AppModules.shared.userPreferences
    private lazy var figures = AppModules.shared.gameResources.allFigures.map { $0.name }
    
    convenience init(completion: @escaping (FigureName?) -> Void) {
        self.init(title: "Choose figure", message: nil, preferredStyle: .alert)
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
