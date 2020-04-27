//
//  Single+Transaction.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

extension Single {
    
    static func transaction(_ function: @escaping (() -> Void)) -> Completable {
        Completable.create { completable in
            function()
            completable(.completed)
            return Disposables.create()
        }
    }
    
    static func cardTransaction(_ function: @escaping (() -> CardProtocol)) -> Single<CardProtocol> {
        Single.create { single in
            let card = function()
            single(.success(card))
            return Disposables.create()
        }
    }
    
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
