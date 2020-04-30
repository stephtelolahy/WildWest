//
//  Single+FirebaseTransaction.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

extension Single {
    
    static func firebaseTransaction(_ function: @escaping ((@escaping FirebaseCompletion) -> Void)) -> Completable {
        Completable.create { completable in
            let completion: FirebaseCompletion = { result in
                switch result {
                case .success:
                    completable(.completed)
                case let .error(error):
                    completable(.error(error))
                }
            }
            function(completion)
            return Disposables.create()
        }
    }
    
    static func firebaseCardTransaction(_ function: @escaping ((@escaping FirebaseCardCompletion) -> Void))
        -> Single<CardProtocol> {
            Single.create { single in
                let completion: FirebaseCardCompletion = { result in
                    switch result {
                    case let .success(card):
                        single(.success(card))
                    case let .error(error):
                        single(.error(error))
                    }
                }
                function(completion)
                return Disposables.create()
            }
    }
}
