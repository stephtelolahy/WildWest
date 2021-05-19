//
//  AuthProvider.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/08/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import FirebaseUI

protocol AuthProviderProtocol {
    var loggedInUserId: String? { get }
}

class AuthProvider: AuthProviderProtocol {
    
    var loggedInUserId: String? {
        Auth.auth().currentUser?.uid
    }
}
