//
//  DXUITextField.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 23.07.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit
import Layout

// MARK: - DXUITextField

public class DXUITextField: StylableUIView<DXUITextField.Appearance> {
    
    // MARK: - Mode
    
    public enum Mode {
        case `default`
        case password
    }
    
    // MARK: - Subviews
    
    /// Vertical stack view instance
    private let stack = UIStackView().then {
        $0.axis = .vertical
    }
    
    /// Title of the text field
    private let titleLabel = UILabel()
    
    /// Text field instance
    public let textField = ChainableTextField().then {
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.textContentType = .oneTimeCode
    }
    
    /// Subtitle of the text field
    private let subtitleLabel = DXInfoLabel()
    
    // MARK: - Properties
    
    public var titleText: String? {
        didSet {
            titleLabel.text = titleText
            titleLabel.isHidden = (titleText ?? "").isEmpty
        }
    }
    
    public var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
            stylePlaceholder(with: appearance)
        }
    }
    
    public var subtitleText: String? {
        didSet {
            subtitleLabel.text = subtitleText
            subtitleLabel.isHidden = (subtitleText ?? "").isEmpty
        }
    }
    
    public var state: UIState = .normal {
        didSet {
            updateTextFieldState()
            subtitleLabel.state = state
        }
    }

    public var didChangeText: ((String) -> ())?
    
    public var mode: Mode = .default {
        didSet {
            switch mode {
            case .default:
                isSecureTextEntry = false
            case .password:
                isSecureTextEntry = true
            }
            updateTextFieldState(shouldChangeText: false)
        }
    }
    
    private var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
            updateSecureButtonState()
        }
    }
    
    /// Maximum length of the text field's input
    public var maxLength: Int?
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        prepareForAutolayout()
        setupStackView()
        setupTitleLabel()
        setupTextField()
        setupInfoLabel()
    }
    
    private func setupStackView() {
        stack.prepareForAutolayout()
        addSubview(stack)
        stack.pin(to: self)
    }
    
    private func setupTitleLabel() {
        titleLabel.isHidden = true
        titleLabel.prepareForAutolayout()
        stack.addArrangedSubview(titleLabel)
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.prepareForAutolayout()
        stack.addArrangedSubview(textField)
        textField.height(LayoutConstants.TextField.height)
    }
    
    private func setupInfoLabel() {
        subtitleLabel.isHidden = true
        subtitleLabel.prepareForAutolayout()
        stack.addArrangedSubview(subtitleLabel)
    }
    
    // MARK: - Style
    
    public override func style(with appearance: Appearance) {
        styleStack(with: appearance)
        styleTitle(with: appearance)
        styleTextField(with: appearance)
        styleSubtitle(with: appearance)
        stylePlaceholder(with: appearance)
    }
    
    private func styleStack(with appearance: Appearance) {
        stack.spacing = appearance.stackSpacing
    }
    
    private func styleTitle(with appearance: Appearance) {
        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleColor
    }
    
    private func styleTextField(with appearance: Appearance) {
        switch state {
        case .normal where textField.isFirstResponder:
            textField.layer.borderColor = appearance.focusedFrameColor.cgColor
            textField.textColor = appearance.textColor
            textField.tintColor = appearance.textColor
            textField.layer.borderWidth = appearance.borderWidth + 1
        case .normal where !textField.isFirstResponder:
            textField.layer.borderColor = appearance.frameColor.cgColor
            textField.textColor = appearance.textColor
            textField.tintColor = appearance.textColor
            textField.layer.borderWidth = appearance.borderWidth
        case .error(let isBorderColorEnabled):
            if isBorderColorEnabled {
                textField.layer.borderColor = appearance.errorColor.cgColor
            }
            textField.textColor = appearance.errorColor
            textField.tintColor = appearance.errorColor
            textField.layer.borderWidth = appearance.borderWidth
        default:
            return
        }
        textField.layer.borderWidth = appearance.borderWidth
        textField.layer.cornerRadius = appearance.cornerRadius
        textField.font = appearance.textFont
        textField.addLeftSpacing(LayoutConstants.TextField.insets.left)
    }
    
    private func stylePlaceholder(with appearance: Appearance) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor: appearance.placeholderColor,
                NSAttributedString.Key.font: appearance.placeholderFont
            ]
        )
    }
    
    private func styleSubtitle(with appearance: Appearance) {
        subtitleLabel.style(with: appearance.infoLabel)
    }
    
    // MARK: - Life Cycle
    
    @objc private func clearTextField() {
        textField.text = ""
        updateTextFieldState()
    }
    
    @objc private func secureButtonTapped() {
        isSecureTextEntry.toggle()
    }
    
    @objc private func updateTextFieldState(shouldChangeText: Bool = true) {
        if shouldChangeText {
            didChangeText?(textField.text ?? "")
        }
        updateClearButtonState()
        style(with: appearance)
    }
    
    private func updateClearButtonState() {
        guard mode != .password else { return }
        if !(self.textField.text ?? "").isEmpty {
            let clearButton = UIButton(type: .custom)
            clearButton.setImage(CoreAssets.closeSmall.image, for: .normal)
            clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
            textField.rightView = clearButton.safelyWrapped(withInsets: LayoutConstants.TextField.ClearButton.insets)
            textField.rightViewMode = .whileEditing
        } else {
            textField.rightView = nil
        }
    }
    
    private func updateSecureButtonState() {
        let secureButton = UIButton(type: .custom)
        let secureImage = (isSecureTextEntry ? appearance.securedImage : appearance.unsecuredImage)
        secureButton.setImage(secureImage, for: .normal)
        secureButton.tintColor = appearance.secureImageColor
        secureButton.addTarget(self, action: #selector(secureButtonTapped), for: .touchUpInside)
        textField.rightView = secureButton.safelyWrapped(withInsets: LayoutConstants.TextField.ClearButton.insets)
        textField.rightViewMode = .always
    }
}

// MARK: - UITextFieldDelegate

extension DXUITextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateTextFieldState()
    }
    
    @objc public func textDidChange(_ textField: UITextField) {
        updateTextFieldState()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        updateTextFieldState()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let maxLength = maxLength, !string.isEmpty {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updatedText.count <= maxLength
        }
        return !string.unicodeScalars.contains { $0.properties.isEmoji }
    }
}

// MARK: - Appearance

public extension DXUITextField {
    
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

// MARK: - LayoutConstants

extension DXUITextField {
    
    public enum LayoutConstants {
        
        // MARK: - Stack
        
        public enum Stack {
            
            // MARK: - Constants
            
            public static let spacing: CGFloat = 8
        }
        
        // MARK: - TextField
        
        public enum TextField {
            
            // MARK: - Constants
            
            public static let height: CGFloat = 45
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

// MARK: - Preview

import SwiftUI
import Then

private struct TestView: View {
    
    let textField = DXUITextField().then { textField in
        textField.titleText = "Hello!"
        textField.subtitleText = "Test subtititle"
        textField.placeholder = "Placeholder"
        textField.state = .error()
        textField.prepareForAutolayout()
        textField.width(350)
    }
    
    @State var title = "Hello!"
    @State var placeholder = "Placeholder"
    @State var subtitle = "Test subtititle"
    
    var body: some View {
        VStack {
            textField
                .swiftUI()
                .frame(width: 350, height: 250)
            HStack(spacing: 45) {
                Button(role: .cancel) {
                    textField.state = .normal
                } label: {
                    Text("NORMAL")
                }
                .padding()
                .background(Color.blue.opacity(0.6))
                .clipShape(Capsule())
                Button(role: .destructive) {
                    textField.state = .error()
                } label: {
                    Text("ERROR")
                }
                .padding()
                .background(Color.red.opacity(0.6))
                .clipShape(Capsule())
            }
            .padding(.bottom, 40)
            Button(role: .cancel) {
                switch textField.mode {
                case .default:
                    textField.mode = .password
                case .password:
                    textField.mode = .default
                }
            } label: {
                Text("SECURED?")
            }
            .padding()
            .background(Color.blue.opacity(0.6))
            .clipShape(Capsule())
            if #available(iOS 17.0, *) {
                VStack(alignment: .leading) {
                    Text("Title")
                    TextField("Enter title", text: $title)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1))
                        .onChange(of: title) {
                            textField.titleText = title
                        }
                }
                VStack(alignment: .leading) {
                    Text("Placeholder")
                    TextField("Enter placeholder", text: $placeholder)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1))
                        .onChange(of: placeholder) {
                            textField.placeholder = placeholder
                        }
                }
                VStack(alignment: .leading) {
                    Text("Subtile")
                    TextField("Enter subtitle", text: $subtitle)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1))
                        .onChange(of: subtitle) {
                            textField.subtitleText = subtitle
                        }
                }
            }
            Spacer()
        }
        .padding()
    }
}

import SwiftUI

// MARK: - DXUITextField

public struct DXUITextFieldSUIView: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// Title text
    public var titleText: String?
    
    /// UI state
    public var state: UIState?
    
    /// Current text
    @Binding public var text: String
    
    /// Width
    public let width: CGFloat?
    
    /// View
    public let mode: DXUITextField.Mode
    
    /// Text Field max length
    public let maxLength: Int?
    
    // MARK: - Initializers
    
    public init(
        titleText: String? = nil,
        state: UIState? = nil,
        text: Binding<String>,
        width: CGFloat?,
        mode: DXUITextField.Mode,
        maxLength: Int? = nil
    ) {
        self.state = state
        self.titleText = titleText
        self._text = text
        self.width = width
        self.mode = mode
        self.maxLength = maxLength
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> DXUITextField {
        let textField = DXUITextField()
        textField.didChangeText = { text in
            self.text = text
        }
        textField.mode = mode
        textField.maxLength = maxLength
        if let titleText {
            textField.titleText = titleText
        }
        if let state {
            textField.state = state
        }
        if let width {
            textField.prepareForAutolayout()
            textField.width(width)
        }
        return textField
    }
    
    public func updateUIView(_ uiView: DXUITextField, context: Context) {
        uiView.textField.text = text
        if let state {
            uiView.state = state
        }
    }
}

// MARK: - Preview

#Preview {
    TestView()
}
