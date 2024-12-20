//
//  ChainableTextFieldDelegate.swift
//  Auth IOS
//
//  Created by incetro on 5/31/21.
//
// 101-ui

import Foundation

// MARK: - ChainableTextFieldDelegate

public protocol ChainableTextFieldDelegate: AnyObject {

    /// Bacward button has been pressed
    /// - Parameter textField: triggering text field instance
    func onBackwardPressed(_ textField: ChainableTextField)
}
