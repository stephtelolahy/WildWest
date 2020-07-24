//
//  MatchingManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import FirebaseUI
import RxSwift

protocol MatchingManagerProtocol {
    func createUser() -> Completable
    func observeUserStatus() -> Observable<UserStatus>
}

class MatchingManager: MatchingManagerProtocol {
    
    private let database: MatchingDatabaseProtocol
    
    init(database: MatchingDatabaseProtocol) {
        self.database = database
    }
    
    func createUser() -> Completable {
        guard let user = Auth.auth().currentUser else {
            fatalError("Missing user")
        }
        
        let userInfo = WUserInfo(id: user.uid,
                                 name: user.displayName ?? "",
                                 photoUrl: user.photoURL?.absoluteString ?? "")
        return database.createUser(userInfo)
    }
    
    func observeUserStatus() -> Observable<UserStatus> {
        guard let user = Auth.auth().currentUser else {
            fatalError("Missing user")
        }
        
        return database.observeUserStatus(user.uid)
    }
}
