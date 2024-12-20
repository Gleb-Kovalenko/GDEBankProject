//
//  DispatchQueue.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - DispatchQueue

extension DispatchQueue {

    private static var _onceTracker: [String] = []

    static func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }

    static func once(object: AnyObject, block: () -> Void) {
        let token = ObjectIdentifier(object).debugDescription
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}

func async(after interval: TimeInterval, block: VoidClosure?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        block?()
    }
}

func async(_ block: VoidClosure?) {
    DispatchQueue.main.async {
        block?()
    }
}
