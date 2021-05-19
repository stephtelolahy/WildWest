//
//  DatabaseReferenceProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 13/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

import Firebase
import RxSwift

protocol DatabaseReferenceProtocol {
    func childByAutoIdKey() -> String
    func childRef(_ path: String) -> DatabaseReferenceProtocol
    func observeSingleEvent(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)
    func observe(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)
    func setValue(_ path: String, value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void)
}

extension DatabaseReference: DatabaseReferenceProtocol {
    
    func childByAutoIdKey() -> String {
        childByAutoId().key!
    }
    
    func childRef(_ path: String) -> DatabaseReferenceProtocol {
        child(path)
    }
    
    func observeSingleEvent(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?) {
        child(path).observeSingleEvent(of: eventType, with: block, withCancel: cancelBlock)
    }
    
    func observe(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?) {
        child(path).observe(eventType, with: block, withCancel: cancelBlock)
    }
    
    func setValue(_ path: String, value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void) {
        child(path).setValue(value, withCompletionBlock: block)
    }
    
}

extension DatabaseReferenceProtocol {
    
    func rxSetValue(_ path: String, encoding: @escaping (() throws -> Any?)) -> Completable {
        Completable.create { completable in
            do {
                let value = try encoding()
                self.setValue(path, value: value) { error, _ in
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
    
    func rxObserveSingleEvent<T>(_ path: String, decoding: @escaping ((DataSnapshot) throws -> T)) -> Single<T> {
        Single.create { single in
            self.observeSingleEvent(path, eventType: .value, with: { snapshot in
                do {
                    let object = try decoding(snapshot)
                    single(.success(object))
                } catch {
                    single(.failure(error))
                }
            }) { error in
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func rxObserve<T>(_ path: String, decoding: @escaping ((DataSnapshot) throws -> T)) -> Observable<T> {
        Observable.create { observer in
            self.observe(path, eventType: .value, with: { snapshot in
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
