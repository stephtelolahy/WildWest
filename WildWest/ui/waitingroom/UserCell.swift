//
//  UserCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func update(with user: UserInfo) {
        nameLabel.text = user.name
        photoImageView.kf.setImage(with: URL(string: user.photoUrl))
    }
}
