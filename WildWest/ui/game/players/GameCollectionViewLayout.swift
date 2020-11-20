//
//  GameCollectionViewLayout.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol GameCollectionViewLayoutDelegate: class {
    func numberOfItemsForGameCollectionViewLayout( layout: GameCollectionViewLayout) -> Int
}

class GameCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate: GameCollectionViewLayoutDelegate?
    
    //An array to cache the calculated attributes
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private let cellPadding: CGFloat = 16
    
    //Setting the content size
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            fatalError("Illegal state")
        }
        
        let insets = collectionView.contentInset
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width - (insets.left + insets.right),
                      height: bounds.height - (insets.left + insets.right))
    }
    
    override func prepare() {
        //We begin measuring the location of items only if the cache is empty
        guard cache.isEmpty,
            let numberOfItems = delegate?.numberOfItemsForGameCollectionViewLayout(layout: self) else {
                return
        }
        
        let cellFrames = GameLayoutBuilder().buildLayout(for: numberOfItems,
                                                         size: collectionViewContentSize,
                                                         padding: cellPadding)
        
        for item in 0..<numberOfItems {
            if let frame = cellFrames[item] {
                let indexPath = IndexPath(item: item, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
            }
        }
    }
    
    //Is called  to determine which items are visible in the given rect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        //Loop through the cache and look for items in the rect
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    //The attributes for the item at the indexPath
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.item]
    }
}
