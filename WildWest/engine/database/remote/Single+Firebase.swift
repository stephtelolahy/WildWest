//
//  Single+Firebase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 20/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

import RxSwift
import Firebase

extension DatabaseReference {
    
    func rxSetValue(_ encoding: @escaping (() throws -> Any?)) -> Completable {
        Completable.create { completable in
            do {
                let value = try encoding()
                self.setValue(value) { error, _ in
                    if let error = error {
                        completable(.error(error))
                    } else {
                        completable(.completed)
                    }
                }
            } catch {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func rxObserveSingleEvent<T>(_ decoding: @escaping ((DataSnapshot) throws -> T)) -> Single<T> {
        Single.create { single in
            self.observeSingleEvent(of: .value, with: { snapshot in
                do {
                    let object = try decoding(snapshot)
                    single(.success(object))
                } catch {
                    single(.error(error))
                }
            }) { error in
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
