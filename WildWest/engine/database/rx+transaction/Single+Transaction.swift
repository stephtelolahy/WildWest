//
//  Single+Transaction.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

extension Completable {
    
    static func firebaseTransaction(_ function: @escaping ((@escaping FirebaseCompletion) -> Void)) -> Completable {
        Completable.create { completable in
            let completion: FirebaseCompletion = { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            function(completion)
            return Disposables.create()
        }
    }
}

extension Single {
    static func firebaseCardTransaction(_ function: @escaping ((@escaping FirebaseCardCompletion) -> Void))
        -> Single<CardProtocol> {
        Single.create { single in
            let completion: FirebaseCardCompletion = { card, error in
                if let error = error {
                    single(.error(error))
                } else {
                    single(.success(card!))
                }
            }
            function(completion)
            return Disposables.create()
        }
    }
}
