//
//  Publishers.swift
//  Done
//
//  Created by incetro on 12/30/22.
//

import Combine

extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(to path: ReferenceWritableKeyPath<Root, Output?>, on instance: Root) -> Cancellable {
        sink { instance[keyPath: path] = $0 }
    }
}
