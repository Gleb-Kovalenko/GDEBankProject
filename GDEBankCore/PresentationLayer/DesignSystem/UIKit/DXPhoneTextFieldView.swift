//
//  DXPhoneTextFieldView.swift
//  Auth IOS
//
//  Created by incetro on 6/11/21.
//

import UIKit
import Layout
import InputMask
import UIKitActions
import HapticFeedback

// MARK: - DXPhoneTextFieldView

open class DXPhoneTextFieldView: StylableUIView<DXPhoneTextFieldView.Appearance> {
    
    // MARK: - Aliases
    
    public typealias CodeLabelTap = (String) -> Void
    
    // MARK: - Properties
    
    /// HapticFeedback instance
    private let hapticFeedback = HapticFeedback()
    
    /// Current phone value
    public var phone: String {
        guard let code = codeLabel.text, let phone = phoneTextField.text else {
            return ""
        }
        return (code + phone).digits
    }
    
    /// MaskedTextFieldDelegate instance
    public let loginTextFieldListener = CustomMaskedTextFieldDelegate().then {
        $0.affineFormats = ["[000000000000]"]
    }
    
    /// MaskedTextFieldDelegate instance
    public let maskTextFieldListener = MaskedTextInputListener().then {
        $0.affineFormats = ["[000000000000]"]
    }
    
    /// Phone country code label
    public let codeLabel = UILabel().then {
        $0.text = "+7"
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    /// Phone number text field
    public let phoneTextField = ChainableTextField().then {
        $0.keyboardType = .numberPad
        $0.textAlignment = .left
    }
    
    /// Phone number text field
    public let maskTextField = ChainableTextField().then {
        $0.keyboardType = .phonePad
        $0.rightViewMode = .never
        $0.isUserInteractionEnabled = false
    }
    
    private let textFieldContainerView = UIView()
    
    private let codePickerButton = DXDropdownButton()
    
    public var state: UIState = .normal {
        didSet {
            updateTextFieldState()
        }
    }
    
    /// `codeLabel` tap handler
    public var codeLabelTap: CodeLabelTap?
    
    /// Mask construction element
    public let maskCharacter: Character = "ˍ"
    
    /// Available country codes for number
    public var countryCodes = ["+7", "8"]
    
    /// Calls when text changes in field
    public var textUpdatedClosure: ((String) -> ())?
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupMaskListners()
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupMaskListners() {
        phoneTextField.delegate = loginTextFieldListener
        maskTextField.delegate = maskTextFieldListener
        loginTextFieldListener.onMaskedTextChangedCallback = { [weak self] _, value, _, _ in
            guard let self else { return }
            self.textUpdatedClosure?(self.phone)
        }
        maskTextFieldListener.customNotations = [
            Notation(
                character: "7",
                characterSet: CharacterSet(charactersIn: "ˍ-").union(.decimalDigits),
                isOptional: true
            ),
        ]
        phoneTextField.defaultTextAttributes = [
            NSAttributedString.Key.kern: 0,
            NSAttributedString.Key.font: UIFont.inter(size: 16, weight: .medium).monospacedDigitFont
        ]
        maskTextField.defaultTextAttributes = [
            NSAttributedString.Key.baselineOffset: -2,
            NSAttributedString.Key.kern: 4,
            NSAttributedString.Key.font: UIFont.inter(size: 16, weight: .medium).monospacedTextFont
        ]
        phoneTextField.addTarget(self, action: #selector(updateTextFieldState), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(updateTextFieldState), for: .editingDidEnd)
    }
    
    private func updateClearButtonState() {
        if !(phoneTextField.text ?? "").isEmpty {
            let clearButton = UIButton(type: .custom)
            clearButton.setImage(GDEBankCore.Assets.closeSmall.image, for: .normal)
            clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
            phoneTextField.rightView = clearButton.safelyWrapped(withInsets: LayoutConstants.TextField.ClearButton.insets)
            phoneTextField.rightViewMode = .whileEditing
        } else {
            phoneTextField.rightView = nil
        }
    }
    
    @objc private func clearTextField() {
        phoneTextField.text = ""
        textUpdatedClosure?("")
        _ = loginTextFieldListener.textFieldShouldClear(phoneTextField)
    }
    
    @objc func updateTextFieldState() {
        updateClearButtonState()
        style(with: appearance)
    }
    
    
    // MARK: - Useful
    
    open func updateMask(_ mask: String) {
        phoneTextField.text = ""
        loginTextFieldListener.affineFormats = [mask]
        maskTextFieldListener.affineFormats = [mask]
    }
    
    open func updateCode(_ code: String) {
        codeLabel.text = code
    }
    
    // MARK: - Style
    
    public override func style(with appearance: Appearance) {
        styleTextField(with: appearance)
        styleCodeLabel(with: appearance)
    }
    
    private func styleTextField(with appearance: Appearance) {
        switch state {
        case .normal where phoneTextField.isFirstResponder:
            textFieldContainerView.layer.borderWidth = appearance.borderWidth + 1
            textFieldContainerView.layer.borderColor = appearance.focusedFrameColor.cgColor
            phoneTextField.textColor = appearance.textColor
            phoneTextField.tintColor = appearance.textColor
            maskTextField.textColor = Colors.gray4.color
        case .normal where !phoneTextField.isFirstResponder:
            textFieldContainerView.layer.borderWidth = appearance.borderWidth
            textFieldContainerView.layer.borderColor = appearance.frameColor.cgColor
            phoneTextField.textColor = appearance.textColor
            maskTextField.textColor = Colors.gray4.color
            phoneTextField.tintColor = appearance.textColor
        case .error:
            textFieldContainerView.layer.borderColor = appearance.errorColor.cgColor
            phoneTextField.textColor = appearance.errorColor
            maskTextField.textColor = appearance.errorColor.withAlphaComponent(0.6)
            textFieldContainerView.layer.borderWidth = appearance.borderWidth
            phoneTextField.tintColor = appearance.errorColor
        default:
            return
        }
        textFieldContainerView.layer.cornerRadius = appearance.cornerRadius
    }
    
    private func styleCodeLabel(with appearance: Appearance) {
        switch state {
        case .normal:
            codeLabel.textColor = appearance.textColor
        case .error:
            codeLabel.textColor = appearance.errorColor
        }
    }
}

// MARK: - CustomMaskedTextFieldDelegate

public class CustomMaskedTextFieldDelegate: MaskedTextInputListener {
    
    // MARK: - Properties
    
    private var maskLength: Int {
        affineFormats.first?.digits.count ?? 0
    }
    
    // MARK: - Useful
    
    private func updateMaskText(textField: DXPhoneTextFieldView, newString: String) {
        let currentLength = newString.digits.count
        let targetLength = maskLength
        let targetLengthToAppend = targetLength - currentLength
        let stringToAppend = Array(
            repeating: String(textField.maskCharacter),
            count: targetLengthToAppend > 0 ? targetLengthToAppend : 0
        ).joined()
        let newStringToAppend = Array(
            repeating: String("-"),
            count: currentLength
        ).joined()
        let newMask = newStringToAppend + stringToAppend
        let mask = Array(
            repeating: String(textField.maskCharacter),
            count: targetLength
        ).joined()
        _ = textField.maskTextFieldListener.textField(
            textField.maskTextField,
            shouldChangeCharactersIn: NSRangeFromString(mask),
            replacementString: newMask
        )
    }
    
    // MARK: - MaskedTextFieldDelegate
    
    public override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText),
              let phoneTextFieldView = textField.superview as? DXPhoneTextFieldView
        else {
            return false
        }
        var updatedText = currentText.replacingCharacters(in: textRange, with: string)
        for countryCode in phoneTextFieldView.countryCodes where updatedText.hasPrefix(countryCode) && updatedText.digits.count > maskLength {
            updatedText = String(updatedText.dropFirst(countryCode.count))
            updateMaskText(textField: phoneTextFieldView, newString: updatedText)
            return super.textField(textField, shouldChangeCharactersIn: range, replacementString: updatedText)
        }
        updateMaskText(textField: phoneTextFieldView, newString: updatedText)
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    public override func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let phoneTextFieldView = textField.superview as? DXPhoneTextFieldView {
            let mask = Array(
                repeating: String(phoneTextFieldView.maskCharacter),
                count: phoneTextFieldView.maskTextFieldListener.affineFormats.first?.count ?? 0
            ).joined()
            _ = phoneTextFieldView.maskTextFieldListener.textField(
                phoneTextFieldView.maskTextField,
                shouldChangeCharactersIn: NSRange(location: 0, length: 0),
                replacementString: mask
            )
        }
        return true
    }
    
    public override func textFieldDidBeginEditing(_ textField: UITextField) {
        if let phoneTextFieldView = textField.superview as? DXPhoneTextFieldView {
            phoneTextFieldView.updateTextFieldState()
        }
    }
}

// MARK: - Layout

private extension DXPhoneTextFieldView {
    
    func setup() {
        setupCodePicker()
        setupContainerView()
        setupCodeLabel()
        setupPhoneTextField()
        setupMaskLabel()
    }
    
    func setupCodePicker() {
        addSubview(codePickerButton.prepareForAutolayout())
        codePickerButton
            .pin(to: self, excludingSide: .right)
            .width(116)
        
        codePickerButton.countryDidChanged = { [weak self] in
            self?.codeLabel.text = $0.code.replacingOccurrences(of: " ", with: "")
        }
    }
    
    func setupContainerView() {
        addSubview(textFieldContainerView.prepareForAutolayout())
        textFieldContainerView
            .left(to: codePickerButton.right + 8)
            .right(to: self.right)
            .bottom(to: self.bottom)
            .top(to: self.top)
    }
    
    func setupCodeLabel() {
        textFieldContainerView.addSubview(codeLabel.prepareForAutolayout())
        codeLabel
            .left(to: textFieldContainerView.left + Constants.codeLabelInset)
            .centerY(to: textFieldContainerView.centerY)
            .height(Constants.codeLabelSize)
        codeLabel.width.greaterThanOrEqual(to: Constants.codeLabelSize)
        codeLabel.addTap { [weak self] _ in
            guard let self = self else { return }
            self.hapticFeedback.tap()
            self.codeLabelTap?(self.codeLabel.text ?? "")
        }
        
        codeLabel.font = .inter(size: 16, weight: .medium).monospacedDigitFont
    }
    
    func setupPhoneTextField() {
        textFieldContainerView.addSubview(maskTextField.prepareForAutolayout())
        let insets = Constants.phoneTextFieldInsets
        maskTextField
            .left(to: codeLabel.right + insets.left)
            .right(to: textFieldContainerView.right - insets.right)
            .centerY(to: textFieldContainerView.centerY)
        let foregroundView = UIView()
        foregroundView.backgroundColor = Colors.defaultPrimary.color
        textFieldContainerView.addSubview(foregroundView.prepareForAutolayout())
        foregroundView
            .pin(to: maskTextField, withSides: .left, .right, .top)
            .height(18)
    }
    
    func setupMaskLabel() {
        addSubview(phoneTextField.prepareForAutolayout())
        let insets = Constants.phoneTextFieldInsets
        phoneTextField
            .left(to: codeLabel.right + insets.left)
            .right(to: textFieldContainerView.right - insets.right)
            .centerY(to: textFieldContainerView.centerY)
        let mask = Array(
            repeating: String(maskCharacter),
            count: maskTextFieldListener.affineFormats.first?.count ?? 0
        ).joined()
        _ = maskTextFieldListener.textField(
            maskTextField,
            shouldChangeCharactersIn: NSRangeFromString(mask),
            replacementString: mask
        )
    }
}

// MARK: - Appearance

public extension DXPhoneTextFieldView {
    
    struct Appearance: Default {
        
        // MARK: - Images
        
        public let securedImage: UIImage
        public let unsecuredImage: UIImage
        
        // MARK: - Colors
        
        public let frameColor: UIColor
        public let focusedFrameColor: UIColor
        public let titleColor: UIColor
        public let textColor: UIColor
        public let placeholderColor: UIColor
        public let errorColor: UIColor
        public let secureImageColor: UIColor
        
        // MARK: - Fonts
        
        public let titleFont: UIFont
        public let textFont: UIFont
        public let placeholderFont: UIFont
        
        // MARK: - Dimensions
        
        public let stackSpacing: CGFloat
        public let textFieldHeight: CGFloat
        public let borderWidth: CGFloat
        public let cornerRadius: CGFloat
        
        // MARK: - Children
        
        public let infoLabel: DXInfoLabel.Appearance
        
        // MARK: - Initailizers
        
        public init(
            securedImage: UIImage = GDEBankCore.Assets.eyeClosed.image,
            unsecuredImage: UIImage = GDEBankCore.Assets.eye.image,
            frameColor: UIColor = GDEBankCore.Colors.gray2.color,
            focusedFrameColor: UIColor = GDEBankCore.Colors.gray1.color,
            titleColor: UIColor = GDEBankCore.Colors.gray1.color,
            textColor: UIColor = GDEBankCore.Colors.textDefault.color,
            placeholderColor: UIColor = GDEBankCore.Colors.gray4.color,
            errorColor: UIColor = GDEBankCore.Colors.alert1.color,
            secureImageColor: UIColor = GDEBankCore.Colors.gray2.color,
            titleFont: UIFont = .inter(size: 14, weight: .regular),
            textFont: UIFont = .inter(size: 14, weight: .medium),
            placeholderFont: UIFont = .inter(size: 14, weight: .medium),
            stackSpacing: CGFloat = LayoutConstants.Stack.spacing,
            textFieldHeight: CGFloat = LayoutConstants.TextField.height,
            borderWidth: CGFloat = LayoutConstants.TextField.borderWidth,
            cornerRadius: CGFloat = LayoutConstants.TextField.cornerRadius,
            infoLabel: DXInfoLabel.Appearance = .default
        ) {
            self.securedImage = securedImage
            self.unsecuredImage = unsecuredImage
            self.frameColor = frameColor
            self.focusedFrameColor = focusedFrameColor
            self.titleColor = titleColor
            self.textColor = textColor
            self.placeholderColor = placeholderColor
            self.errorColor = errorColor
            self.secureImageColor = secureImageColor
            self.titleFont = titleFont
            self.textFont = textFont
            self.placeholderFont = placeholderFont
            self.stackSpacing = stackSpacing
            self.textFieldHeight = textFieldHeight
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
            self.infoLabel = infoLabel
        }
        
        // MARK: - Default
        
        public static let `default` = Appearance()
    }
}


// MARK: - Constants

public extension DXPhoneTextFieldView {
    
    enum Constants {
        static let codeLabelSize: CGFloat = 22
        static let codeLabelInset: CGFloat = 12
        static let phoneTextFieldInsets = UIEdgeInsets(top: 14, left: 10, bottom: 12, right: 0)
    }
}

// MARK: - LayoutConstants

extension DXPhoneTextFieldView {
    
    public enum LayoutConstants {
        
        // MARK: - Stack
        
        public enum Stack {
            
            // MARK: - Constants
            
            public static let spacing: CGFloat = 8
        }
        
        // MARK: - TextField
        
        public enum TextField {
            
            // MARK: - Constants
            
            public static let height: CGFloat = 50
            public static let borderWidth: CGFloat = 1
            public static let cornerRadius: CGFloat = 12
            public static let insets = UIEdgeInsets.left(12)
            
            // MARK: - ClearButton
            
            public enum ClearButton {
                
                // MARK: - Constants
                
                public static let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 12)
            }
        }
    }
}

import SwiftUI

// MARK: - DXPhoneTextFieldSUIView

public struct DXPhoneTextFieldSUIView: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// Current phone number with country code
    @Binding public var phone: String
    
    /// Current ui state of the view
    @Binding public var state: UIState
    
    // MARK: - Initializers
    
    public init(phone: Binding<String>, state:  Binding<UIState>) {
        self._phone = phone
        self._state = state
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> DXPhoneTextFieldView {
        let textField = DXPhoneTextFieldView()
        textField.textUpdatedClosure = { phone in
            self.phone = phone
        }
        return textField
    }
    
    public func updateUIView(_ uiView: DXPhoneTextFieldView, context: Context) {
        uiView.state = state
    }
}
