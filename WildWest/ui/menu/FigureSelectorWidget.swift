//
//  FigureSelectorWidget.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine
import ImageSlideshow

class FigureSelectorWidget: FullScreenSlideshowViewController {
    
    convenience init(gameResources: ResourcesLoaderProtocol,
                     initialFigure: String?,
                     completion: @escaping (String?) -> Void) {
        self.init()
        modalTransitionStyle = .crossDissolve
        
        let figures = gameResources.loadCards().filter { $0.type == .figure }.map { $0.name }
        let imageNames = ["01_back"] + figures.map { "01_\($0.lowercased())" }
        let images = imageNames.map { BundleImageSource(imageString: $0) }
        let initialIndex: Int
        if let initialfigure = initialFigure,
           let index = figures.firstIndex(of: initialfigure) {
            initialIndex = index + 1
        } else {
            initialIndex = 0
        }
        
        inputs = images
        initialPage = initialIndex
        
        pageSelected = { page in
            
            let selectedFigure: String?
            if page == 0 {
                selectedFigure = nil
            } else {
                selectedFigure = figures[page - 1]
            }
            
            completion(selectedFigure)
        }
    }
}
