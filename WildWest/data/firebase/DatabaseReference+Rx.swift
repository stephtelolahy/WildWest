//
//  DatabaseReference+Rx.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiline_arguments
// swiftlint:disable multiple_closures_with_trailing_closure

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
}

extension DatabaseQuery {
    
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
    
    func rxObserve<T>(_ decoding: @escaping ((DataSnapshot) throws -> T)) -> Observable<T> {
        Observable.create { observer in
            self.observe(.value, with: { snapshot in
                do {
                    let object = try decoding(snapshot)
                    observer.on(.next(object))
                } catch {
                    // ignore decoding errors as we are counting on next emited value
                }
            }) { error in
                observer.on(.error(error))
            }
            return Disposables.create()
        }
    }
}
