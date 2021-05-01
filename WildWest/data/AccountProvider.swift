//
//  AccountProvider.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/08/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import FirebaseUI

protocol AccountProviderProtocol {
    var loggedInUserId: String? { get }
}

class AccountProvider: AccountProviderProtocol {
    
    var loggedInUserId: String? {
        Auth.auth().currentUser?.uid
    }
}
