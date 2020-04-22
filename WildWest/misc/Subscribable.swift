//
//  Subscribable.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

/// Protocol allowing any object to handle disposables on `deinit`.
///
protocol Subscribable {
    func sub(_ disposable: Disposable)
}

extension Subscribable where Self: AnyObject {
    
    func sub(_ disposable: Disposable) {
        disposable.disposed(by: disposeBag)
    }
    
    private var disposeBag: DisposeBag {
        get {
            associatedObject(base: self, key: &AssociatedKeys.disposeBagKey) { DisposeBag() }
        }
        set(newValue) {
            associateObject(base: self, key: &AssociatedKeys.disposeBagKey, value: newValue)
        }
    }
    
    private func associatedObject<ValueType: AnyObject>(
        base: AnyObject,
        key: UnsafePointer<UInt8>,
        initialiser: () -> ValueType)
        -> ValueType {
            if let associated = objc_getAssociatedObject(base, key)
                as? ValueType { return associated }
            let associated = initialiser()
            objc_setAssociatedObject(base, key, associated, .OBJC_ASSOCIATION_RETAIN)
            return associated
    }
    
    private func associateObject<ValueType: AnyObject>(
        base: AnyObject,
        key: UnsafePointer<UInt8>,
        value: ValueType) {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
}

private enum AssociatedKeys {
    static var disposeBagKey: UInt8 = 0
}
