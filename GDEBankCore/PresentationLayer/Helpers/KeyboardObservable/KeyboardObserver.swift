//
//  KeyboardObserver.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import UIKit

// MARK: - KeyboardObserver

final public class KeyboardObserver {

    /// All keyboard observers
    private var observers: [KeyboardObservable] = []

    /// Register new observer
    ///
    /// - Parameter observer: new observer
    public func register(observer: KeyboardObservable) {
        let contains = observers.contains { observable in
            observable === observer
        }
        if !contains {
            observers.append(observer)
        }
    }

    /// Remove some observer
    ///
    /// - Parameter observer: some observer
    public func unregister(observer: KeyboardObservable) {
        let index = observers.firstIndex { observable in
            observable === observer
        }
        if let index {
            observers.remove(at: index)
        }
    }

    // MARK: - Initializers

    public init() {
        registerForKeyboardNotifications()
    }

    deinit {
        unregisterFromKeyboardNotifications()
    }

    /// Set observers for keyboard's events
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide(notification:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }

    /// Keyboard appearing event
    ///
    /// - Parameter notification: some object with keyboard data
    @objc private func keyboardWillShow(notification: NSNotification) {
        let info = KeyboardInfo(userInfo: notification.userInfo ?? [:])
        for observer in observers {
            observer.keyboardWillShow(keyboardInfo: info)
        }
    }

    /// Keyboard appearing event
    ///
    /// - Parameter notification: some object with keyboard data
    @objc private func keyboardDidShow(notification: NSNotification) {
        let info = KeyboardInfo(userInfo: notification.userInfo ?? [:])
        for observer in observers {
            observer.keyboardDidShow(keyboardInfo: info)
        }
    }

    /// Keyboard disappearing event
    ///
    /// - Parameter notification: some object with keyboard data
    @objc private func keyboardWillHide(notification: NSNotification) {
        let info = KeyboardInfo(userInfo: notification.userInfo ?? [:])
        for observer in observers {
            observer.keyboardWillHide(keyboardInfo: info)
        }
    }

    /// Keyboard disappearing event
    ///
    /// - Parameter notification: some object with keyboard data
    @objc private func keyboardDidHide(notification: NSNotification) {
        let info = KeyboardInfo(userInfo: notification.userInfo ?? [:])
        for observer in observers {
            observer.keyboardDidHide(keyboardInfo: info)
        }
    }

    /// Remove observers for keyboard's events
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
