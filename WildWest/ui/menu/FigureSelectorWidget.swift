//
//  FigureSelectorWidget.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class FigureSelectorWidget: UIAlertController {
    
    convenience init(gameResources: ResourcesLoaderProtocol, completion: @escaping (String?) -> Void) {
        self.init(title: "Choose figure", message: nil, preferredStyle: .alert)
        let figures = gameResources.loadCards().filter { $0.type == .figure }.map { $0.name }
        figures.forEach { figure in
            addAction(UIAlertAction(title: figure,
                                    style: .default,
                                    handler: { _ in
                                        completion(figure)
                                    }))
        }
        
        addAction(UIAlertAction(title: "Random",
                                style: .cancel,
                                handler: { _ in
                                    completion(nil)
                                }))
    }
}
