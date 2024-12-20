//
//  KeyboardInfo.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//
// swiftlint:disable line_length

import UIKit

// MARK: - KeyboardInfo

public struct KeyboardInfo {

    // MARK: - Properties

    /// UIKeyboardFrameEndUserInfoKey value
    public let frameEnd: CGRect

    /// UIKeyboardFrameBeginUserInfoKey value
    public let frameBegin: CGRect

    /// UIKeyboardAnimationCurveUserInfoKey value
    public let animationCurve: Int

    /// UIKeyboardAnimationDurationUserInfoKey value
    public let animationDuration: Double

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter userInfo: keyboard event data
    init(userInfo: [AnyHashable: Any]) {
        let frameMapping = { (any: Any?) -> CGRect in
            (any as? NSValue)?.cgRectValue ?? .zero
        }
        self.frameBegin = frameMapping(userInfo[UIResponder.keyboardFrameBeginUserInfoKey])
        self.frameEnd = frameMapping(userInfo[UIResponder.keyboardFrameEndUserInfoKey])
        self.animationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue ?? UIView.AnimationCurve.easeInOut.rawValue
        self.animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
    }
}
