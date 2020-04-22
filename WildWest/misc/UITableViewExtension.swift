//
//  UITableViewExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

extension UITableView {
    
    func reloadDataScrollingAtBottom() {
        reloadData()
        guard numberOfSections > 0 else {
            return
        }
        
        let section = numberOfSections - 1
        let rowsCount = numberOfRows(inSection: section)
        guard rowsCount > 0 else {
            return
        }
        
        let indexPath = IndexPath(item: rowsCount - 1, section: section)
        DispatchQueue.main.async { [weak self] in
            self?.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
