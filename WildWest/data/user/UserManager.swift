//
//  UserManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol UserManagerProtocol {
    var isLoggedIn: Bool { get }
    
    func getUser() -> Single<UserInfo>
    func createUser(_ user: UserInfo) -> Completable
    func observeUserStatus() -> Observable<UserStatus>
    func observeWaitingUsers() -> Observable<[UserInfo]>
    func setStatusWaiting() -> Completable
    func setStatusIdle() -> Completable
}

class UserManager: UserManagerProtocol {
    
    private let authProvider: AuthProviderProtocol
    private let database: MainDatabaseProtocol
    
    init(authProvider: AuthProviderProtocol,
         database: MainDatabaseProtocol) {
        self.authProvider = authProvider
        self.database = database
    }
    
    var isLoggedIn: Bool {
        authProvider.loggedInUserId != nil
    }
    
    func getUser() -> Single<UserInfo> {
        guard let userId = authProvider.loggedInUserId else {
            return Single.error(NSError(domain: "Missing user", code: 0))
        }
        return database.getUser(userId)
    }
    
    func createUser(_ user: UserInfo) -> Completable {
        database.createUser(user)
    }
    
    func observeUserStatus() -> Observable<UserStatus> {
        guard let userId = authProvider.loggedInUserId else {
            return Observable.error(NSError(domain: "Missing user", code: 0))
        }
        return database.observeUserStatus(userId)
    }
    
    func observeWaitingUsers() -> Observable<[UserInfo]> {
        database.observeWaitingUsers()
    }
    
    func setStatusWaiting() -> Completable {
        guard let userId = authProvider.loggedInUserId else {
            return Completable.error(NSError(domain: "Missing user", code: 0))
        }
        return database.setUserStatus(userId, status: .waiting)
    }
    
    func setStatusIdle() -> Completable {
        guard let userId = authProvider.loggedInUserId else {
            return Completable.error(NSError(domain: "Missing user", code: 0))
        }
        
        return database.setUserStatus(userId, status: .idle)
    }
}
