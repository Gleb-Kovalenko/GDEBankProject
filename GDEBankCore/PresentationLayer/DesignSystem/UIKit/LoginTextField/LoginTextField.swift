//
//  LoginTextField.swift
//  UI IOS
//
//  Created by incetro on 6/29/21.
//

import HapticFeedback
import UIKit

// MARK: - LoginTextField

open class LoginTextField: FloatingLabelTextField, Hapticable {

    public init() {
        super.init(frame: .zero)
        delegate = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextFieldDelegate

extension LoginTextField: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self {
            do {
                let regex = try NSRegularExpression(pattern: "[ ЁёА-я]+")
                let range = NSRange(location: 0, length: string.utf16.count)
                let isCorrect = !(regex.firstMatch(in: string, options: [], range: range) != nil)
                if !isCorrect {
                    hapticFeedback.generate(.error)
                }
                return isCorrect
            } catch {
                preconditionFailure("Illegal regular expression.")
            }
        }
        return true
    }
}
