//
//  UICollectionViewExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func setItemSpacing(_ spacing: CGFloat) {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.minimumLineSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    // swiftlint:disable force_cast
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
