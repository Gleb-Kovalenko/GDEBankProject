//
//  UIViewController.swift
//  Auth IOS
//
//  Created by incetro on 5/25/21.
//
// 101-ui

import UIKit

// MARK: - UIViewController

public extension UIViewController {

    /// Make the current view controller's navigation bar clear
    func setupClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }

    /// Reset the current view controller's navigation bar clearing
    func resetClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    /// Setup keyboard hiding when tapped around
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Setup keyboard hiding when swiped down
    func hideKeyboardWhenSwipedDown() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        pan.cancelsTouchesInView = false
        view.addGestureRecognizer(pan)
    }

    /// Keyboard dismiss
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func removeAllSubviews() {
        view.subviews.forEach {
            if let stack = $0 as? UIStackView {
                stack.removeAllSubviews()
            }
            $0.removeFromSuperview()
        }
    }
}

// MARK: - Navigation

public extension UINavigationController {

    func setViewController<T: UIViewController>(
        _ vc: T,
        animated: Bool = true
    ) {
        if viewControllers.first is T { return }
        setViewControllers([vc], animated: false)
    }

    func pushViewController<T: UIViewController>(
        _ vc: T,
        allow
        animated: Bool = true
    ) {
        if viewControllers.first is T { return }
        setViewControllers([vc], animated: false)
    }
}
