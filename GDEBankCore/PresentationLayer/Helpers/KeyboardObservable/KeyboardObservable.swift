//
//  KeyboardObservable.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - KeyboardObservable

public protocol KeyboardObservable: AnyObject {

    /// UIKeyboardWillShow event
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardWillShow(keyboardInfo: KeyboardInfo)

    /// UIKeyboardDidShow
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardDidShow(keyboardInfo: KeyboardInfo)

    /// UIKeyboardWillHide
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardWillHide(keyboardInfo: KeyboardInfo)

    /// UIKeyboardDidHide
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardDidHide(keyboardInfo: KeyboardInfo)
}

public extension KeyboardObservable {

    /// UIKeyboardWillShow event
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardWillShow(keyboardInfo: KeyboardInfo) {
    }

    /// UIKeyboardDidShow
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardDidShow(keyboardInfo: KeyboardInfo) {
    }

    /// UIKeyboardWillHide
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardWillHide(keyboardInfo: KeyboardInfo) {
    }

    /// UIKeyboardDidHide
    ///
    /// - Parameter keyboardInfo: KeyboardInfo object
    func keyboardDidHide(keyboardInfo: KeyboardInfo) {
    }
}
