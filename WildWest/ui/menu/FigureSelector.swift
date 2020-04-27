//
//  FigureSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class FigureSelector {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func selectFigure(within figures: [FigureName], completion: @escaping ((FigureName?) -> Void)) {
        let alertController = UIAlertController(title: "Choose figure",
                                                message: nil,
                                                preferredStyle: .alert)
        
        figures.forEach { figure in
            alertController.addAction(UIAlertAction(title: figure.rawValue,
                                                    style: .default,
                                                    handler: { _ in
                                                        guard let index = figures.firstIndex(of: figure) else {
                                                            return
                                                        }
                                                        completion(figures[index])
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Random",
                                                style: .cancel,
                                                handler: { _ in
                                                    completion(nil)
        }))
        
        viewController.present(alertController, animated: true)
    }
}
