//
//  DXTextField.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 31.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - DXTextField

/// A reusable and customizable text field component with validation and focus management.
/// This component provides a text input field with options for title, placeholder, subtitle, and appearance customization.
/// It also supports validation with dynamic error messages and focus tracking.
public struct DXTextField<Focus: Hashable>: View {
    
    // MARK: - Properties
    
    /// The binding to the text entered in the text field.
    @Binding private var text: String
    
    /// The binding that manages the focus state of the field.
    @FocusState.Binding private var focus: Focus?
    
    /// Text field text color
    @Binding private var textFieldTextColor: Color
    
    /// The target focus value, indicating the specific focus state for this text field.
    private let targetFocus: Focus
    
    /// Determines if the text field is currently focused.
    private var isFocused: Bool {
        focus == targetFocus
    }
    
    /// Max length
    private let maxLength: Int?
    
    /// Indicates is field use as card number field
    private let isCardNumberField: Bool
    
    /// Key board type
    private let keyboardType: UIKeyboardType
    
    /// Text field trainiling view
    private let trailingView: (() -> AnyView)?
    
    /// Optional title displayed above the text field.
    private let title: String?
    
    /// Placeholder text shown when the text field is empty.
    private let placeholder: String?
    
    /// Optional subtitle displayed below the text field. Shows error message if validation fails.
    private let subtitle: String?
    
    /// Format text closure
    private let formatText: ((String) -> String)?
    
    /// Validation closure that checks the text input and provides a validation result and message.
    private let validation: ((String) -> (isValid: Bool, message: String?))?
    
    /// Appearance configuration for the text field, allowing customization of colors, fonts, and layout.
    private let appearance: Appearance
    
    // MARK: - Initializers
    
    /// Initializes a DXTextField with the specified configuration parameters.
    ///
    /// - Parameters:
    ///   - text: Binding to the text field's input.
    ///   - focus: Binding for managing focus state.
    ///   - maxLength: Max text field text length
    ///   - targetFocus: Specific focus target for this text field.
    ///   - title: Optional title displayed above the field.
    ///   - placeholder: Placeholder text for when the field is empty.
    ///   - subtitle: Optional subtitle text displayed below the field.
    ///   - validation: Optional validation closure that returns validity status and error message.
    ///   - appearance: Appearance customization for colors, fonts, and layout.
    public init(
        text: Binding<String>,
        focus: FocusState<Focus?>.Binding,
        targetFocus: Focus,
        isCardNumberField: Bool = false,
        maxLength: Int? = nil,
        keyboardType: UIKeyboardType = .default,
        title: String? = nil,
        placeholder: String? = nil,
        subtitle: String? = nil,
        validation: ((String) -> (isValid: Bool, message: String?))? = nil,
        formatText: ((String) -> String)? = nil,
        appearance: Appearance = .default,
        trailingView: (() -> AnyView)? = nil
    ) {
        self._text = text
        self._focus = focus
        self.targetFocus = targetFocus
        self.isCardNumberField = isCardNumberField
        self.maxLength = maxLength
        self.keyboardType = keyboardType
        self.title = title
        self.placeholder = placeholder
        self.subtitle = subtitle
        self.validation = validation
        self.appearance = appearance
        self.trailingView = trailingView
        self.formatText = formatText
        self._textFieldTextColor = .constant(
            validation?(text.wrappedValue).isValid ?? true
            ? appearance.textColor
            : appearance.errorColor
        )
    }
    
    // MARK: - Computed Properties
    
    /// Checks if the current input is valid based on the provided validation closure.
    private var isValid: Bool {
        validation?(text).isValid ?? true
    }
    
    /// Determines the current border color based on the focus state and validation result.
    private var currentBorderColor: Color {
        if !isValid {
            return appearance.errorColor
        } else {
            return isFocused ? appearance.focusedBorderColor : appearance.defaultBorderColor
        }
    }
    
    /// Determines the current text color based on the validation result.
    private var currentTextColor: Color {
        isValid ? appearance.textColor : appearance.errorColor
    }
    
    /// Determines the current subtitle color based on the validation result.
    private var currentSubtitleColor: Color {
        isValid ? appearance.subtitleColor : appearance.errorColor
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                Text(title)
                    .font(appearance.titleFont)
                    .foregroundStyle(appearance.titleColor)
            }
            
            HStack(spacing: 8) {
                textFieldView
                trailingView?()
            }
            
            if let subtitle = isValid ? subtitle : validation?(text).message {
                HStack(spacing: 4) {
                    CoreAssets.alertCircle.swiftUIImage
                        .dxImage(size: 16, color: currentSubtitleColor)
                    Text(subtitle)
                        .font(.inter(size: 12, weight: .medium))
                    Spacer(minLength: 0)
                }
                .foregroundStyle(currentSubtitleColor)
            }
        }
    }
    
    // MARK: - Subviews
    
    /// The main text field view with a clear button and custom styling.
    private var textFieldView: some View {
        HStack(spacing: 12) {
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .font(appearance.textFieldFont)
                .tint(currentTextColor)
                .foregroundStyle(textFieldTextColor)
                .focused($focus, equals: targetFocus)
                .fixedOnChange(of: text) { newValue in
                    var newString = newValue
                    if let maxLength, newValue.count > maxLength {
                        newString = String(newValue.prefix(maxLength))
                    }
                    if let formatText {
                        newString = formatText(text)
                    }
                    text = newString
                    textFieldTextColor = currentTextColor
                }
            
            // Clear button to reset the text input.
            Button(
                action: {
                    text = ""
                },
                label: {
                    CoreAssets.closeSmall.swiftUIImage
                        .dxImage(size: 24)
                }
            )
            .isOpaque(!text.isEmpty && isFocused)
            .disabled(text.isEmpty && !isFocused)
        }
        .padding(.horizontal, appearance.textFieldOuterHorizontalSpacing)
        .padding(.vertical, appearance.textFieldOuterVerticalSpacing)
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.borderCornerRadius)
                .stroke(lineWidth: LayoutConstants.borderStroke * (isFocused ? 2 : 1))
                .foregroundStyle(currentBorderColor)
        )
        .frame(height: isCardNumberField ? 50 : nil)
    }
    
    // MARK: - Appearance
    
    /// Appearance configuration for the DXTextField, providing options for colors, fonts, and layout properties.
    @AutoInit
    public struct Appearance {
        
        // MARK: - Properties
        
        public let titleFont: Font
        public let titleColor: Color
        public let textFieldFont: Font
        public let textColor: Color
        public let textFieldOuterHorizontalSpacing: CGFloat
        public let textFieldOuterVerticalSpacing: CGFloat
        public let subtitleFont: Font
        public let subtitleColor: Color
        public let defaultBorderColor: Color
        public let focusedBorderColor: Color
        public let errorColor: Color
        
        // MARK: - Variations
        
        public static var `default`: DXTextField.Appearance {
            Appearance(
                titleFont: .inter(size: 14, weight: .regular),
                titleColor: CoreColors.gray1.swiftUIColor,
                textFieldFont: .inter(size: 14, weight: .medium),
                textColor: CoreColors.textDefault.swiftUIColor,
                textFieldOuterHorizontalSpacing: 6,
                textFieldOuterVerticalSpacing: 6,
                subtitleFont: .inter(size: 12, weight: .medium),
                subtitleColor: CoreColors.gray2.swiftUIColor,
                defaultBorderColor: CoreColors.gray2.swiftUIColor,
                focusedBorderColor: CoreColors.gray1.swiftUIColor,
                errorColor: CoreColors.alert1.swiftUIColor
            )
        }
        
        public static var amountTextField: DXTextField.Appearance {
            Appearance(
                titleFont: .inter(size: 14, weight: .regular),
                titleColor: CoreColors.gray1.swiftUIColor,
                textFieldFont: .inter(size: 14, weight: .medium),
                textColor: CoreColors.textDefault.swiftUIColor,
                textFieldOuterHorizontalSpacing: 12,
                textFieldOuterVerticalSpacing: 11.5,
                subtitleFont: .inter(size: 12, weight: .medium),
                subtitleColor: CoreColors.gray2.swiftUIColor,
                defaultBorderColor: CoreColors.gray2.swiftUIColor,
                focusedBorderColor: CoreColors.gray1.swiftUIColor,
                errorColor: CoreColors.alert1.swiftUIColor
            )
        }
        
        public static var noBorderAndSpacings: DXTextField.Appearance {
            Appearance(
                titleFont: .inter(size: 14, weight: .regular),
                titleColor: CoreColors.gray1.swiftUIColor,
                textFieldFont: .inter(size: 14, weight: .medium),
                textColor: CoreColors.textDefault.swiftUIColor,
                textFieldOuterHorizontalSpacing: 0,
                textFieldOuterVerticalSpacing: 0,
                subtitleFont: .inter(size: 12, weight: .medium),
                subtitleColor: CoreColors.gray2.swiftUIColor,
                defaultBorderColor: .clear,
                focusedBorderColor: .clear,
                errorColor: CoreColors.alert1.swiftUIColor
            )
        }
    }
}

// MARK: - Useful

extension DXTextField {
    
    private func maskedText(for value: String) -> String {
        let cleanValue = value.replacingOccurrences(of: " ", with: "")
        let mask = placeholder ?? "XXXX XXXX XXXX XXXX"
        var result = ""
        var index = 0
        
        for char in mask {
            if char == mask.first, index < cleanValue.count {
                let stringIndex = cleanValue.index(cleanValue.startIndex, offsetBy: index)
                result.append(cleanValue[stringIndex])
                index += 1
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    private func updateCardNumber(_ value: String) {
        var formatted = ""
        let cleanValue = value.filter { $0.isNumber }
        for (index, char) in cleanValue.enumerated() {
            if index != 0 && index % 4 == 0 {
                formatted.append(" ")
            }
            formatted.append(char)
        }
        text = String(formatted.prefix(AppConstants.Business.TextFields.maxCardLength))
    }
}

// MARK: - LayoutConstants

/// Layout constants used for styling the DXTextField component.
private enum LayoutConstants {
    public static let borderCornerRadius: CGFloat = 8
    public static let borderStroke: CGFloat = 1
}
