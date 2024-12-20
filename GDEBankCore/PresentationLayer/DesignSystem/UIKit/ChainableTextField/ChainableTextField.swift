//
//  ChainableTextField.swift
//  Auth IOS
//
//  Created by incetro on 5/25/21.
//
// 101-ui

import UIKit

// MARK: - ChainableTextField

open class ChainableTextField: UITextField {

    // MARK: - Properties

    /// Next responder which will be called after pressing
    /// on the returnKey
    public weak var nextControl: UIResponder?

    /// Current `ChainableTextField` instance delegate
    public weak var chainableDelegate: ChainableTextFieldDelegate?

    // MARK: - Initializers

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: - UITextField

    override public func deleteBackward() {
        chainableDelegate?.onBackwardPressed(self)
        super.deleteBackward()
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        action == #selector(UIResponderStandardEditActions.paste(_:))
    }

    // MARK: - Private

    private func setup() {
        addTarget(self, action: #selector(actionKeyboardButtonTapped(sender:)), for: .editingDidEndOnExit)
    }

    @objc private func actionKeyboardButtonTapped(sender: UITextField) {
        switch nextControl {
        case let button as UIButton where button.isEnabled:
            button.sendActions(for: .touchUpInside)
        case .some(let responder):
            responder.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }
}
