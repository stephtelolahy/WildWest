//
//  AccountManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/08/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import FirebaseUI
import RxSwift

protocol AccountManagerProtocol {
    var currentUser: WUserInfo? { get }
}

class AccountManager: AccountManagerProtocol {
    
    var currentUser: WUserInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return WUserInfo(id: user.uid,
                         name: user.displayName ?? "",
                         photoUrl: user.photoURL?.absoluteString ?? "")
    }
}
