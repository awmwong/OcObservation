//
//  OcObservation.swift
//
//  Created by Anthony Wong on 2017-06-28.
//  Copyright © 2017 Anthony Wong. All rights reserved.
//

import UIKit
import RxSwift

extension ObservableType {
    func asAnyObservable() -> Observable<AnyObject> {
        return asObservable()
            .map() { $0 as AnyObject }
    }
    
    func ocObservation() -> OcObservation {
        return OcObservation(obs: asAnyObservable())
    }
}

class OcSubscription: NSObject {
    typealias onNextCallback = (AnyObject) -> Void
    typealias onErrorCallback = (Error) -> Void
    typealias onCompletedCallback = () -> Void
    typealias onDisposed = () -> Void
    
    let onNext: onNextCallback?
    let onError: onErrorCallback?
    let onCompleted: onCompletedCallback?
    let onDisposed: onDisposed?
    
    init(onNext: onNextCallback? = nil, onError: onErrorCallback? = nil, onCompleted: onCompletedCallback? = nil, onDisposed: onDisposed? = nil) {
        self.onNext = onNext
        self.onError = onError
        self.onCompleted = onCompleted
        self.onDisposed = onDisposed
        super.init()
    }
}

class OcObservation: NSObject {
    let source: Observable<AnyObject>
    
    var disposeBag = DisposeBag()
    var subscriptions = Set<OcSubscription>()
    
    init(obs: Observable<AnyObject>) {
        source = obs
        super.init()
    }
    
    func addSubscription(_ subscription: OcSubscription) {
        source
            .subscribe(onNext: subscription.onNext,
                       onError: subscription.onError,
                       onCompleted: subscription.onCompleted,
                       onDisposed: subscription.onDisposed)
            .addDisposableTo(disposeBag)
    }
    
    func disposeAll() {
        disposeBag = DisposeBag()
    }
}
