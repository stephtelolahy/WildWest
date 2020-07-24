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
    func requestGame() -> Completable
    func quitWaitingRoom() -> Completable
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
        database.observeUserStatus(currentUserId)
    }
    
    func requestGame() -> Completable {
        database.setUserStatus(currentUserId, status: .waiting)
            .andThen(match())
    }
    
    func quitWaitingRoom() -> Completable {
        database.setUserStatus(currentUserId, status: .idle)
    }
}

private extension MatchingManager {
    
    var currentUserId: String {
        guard let user = Auth.auth().currentUser else {
            fatalError("Missing user")
        }
        
        return user.uid
    }
    
    func match() -> Completable {
        // TODO: try matching
        Completable.empty()
    }
}
