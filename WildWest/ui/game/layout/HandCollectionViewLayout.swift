//
//  HandCollectionViewLayout.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class HandCollectionViewLayout: UICollectionViewFlowLayout {
    
    // MARK: Layout Overrides
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: minimumInteritemSpacing,
                                                   bottom: 0,
                                                   right: minimumInteritemSpacing)
        
        let availableHeight = collectionView.bounds.height
        
        let spacing: CGFloat = self.minimumInteritemSpacing
        let ratio: CGFloat = 250.0 / 389.0
        let cellHeight: CGFloat = availableHeight - 2 * spacing
        let cellWidth: CGFloat = cellHeight * ratio
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: 0.0,
                                         right: 0.0)
        if #available(iOS 11.0, *) {
            self.sectionInsetReference = .fromSafeArea
        } else {
            // TODO: Fallback on earlier versions
        }
    }
}
