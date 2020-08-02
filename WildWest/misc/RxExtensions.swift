//
//  RxExtensions.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

extension Single {
    static func create<T>(_ function: @escaping (() throws -> T)) -> Single<T> {
        Single.create { single in
            do {
                let object = try function()
                single(.success(object))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}

extension Completable {
    static func create(_ function: @escaping (() -> Void)) -> Completable {
        Completable.create { completable in
            function()
            completable(.completed)
            return Disposables.create()
        }
    }
}
