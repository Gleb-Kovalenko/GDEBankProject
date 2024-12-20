//
//  DXButtton.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 18.07.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - DXButtonStyle

public struct DXButtonStyle: ButtonStyle {
    
    // MARK: - Default
    
    private let defaultCornerRadius: CGFloat = 12
    private let defaultHeight: CGFloat = 50
    private let defaultPadding: CGFloat = 18
    
    public static let defaultFontSize: CGFloat = 18
    public static let defaultFontLinkSize: CGFloat = 14
    public static let defaultFontTextSize: CGFloat = 16
    public static let defaultFontControlTextSize: CGFloat = 13
    
    // MARK: - Properties
    
    public var color: Color?
    public var textColor: Color?
    public var pressedColor: Color?
    public var padding: CGFloat?
    public var cornerRadius: CGFloat?
    public var height: CGFloat?
    public let style: DXButton.Style
    public var font: Font?
    public var shouldExpand: Bool
    
    // MARK: - ButtonStyle
    
    public func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        switch style {
        case .fill:
            return AnyView(
                FillButton(
                    color: color,
                    textColor: textColor ?? Colors.buttonTitle.swiftUIColor,
                    pressedColor: pressedColor ?? Colors.buttonFilledPress.swiftUIColor,
                    padding: padding ?? defaultPadding,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    height: height ?? defaultHeight,
                    configuration: configuration,
                    font: font
                )
            )
        case .secondary:
            return AnyView(
                SecondaryButton(
                    color: color ?? Colors.buttonSecondaryPrimary.swiftUIColor,
                    textColor: textColor ?? Colors.buttonTitle.swiftUIColor,
                    pressedColor: pressedColor ?? Colors.buttonSecondaryPress.swiftUIColor,
                    padding: padding ?? defaultPadding,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    height: height ?? defaultHeight,
                    configuration: configuration,
                    font: font
                )
            )
        case .text:
            return AnyView(
                TextButton(
                    textColor: textColor ?? Colors.textDefault.swiftUIColor,
                    padding: padding ?? defaultPadding,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    height: height ?? defaultHeight,
                    configuration: configuration,
                    font: font
                )
            )
        case .outline:
            return AnyView(
                OutlineButton(
                    color: color ?? Colors.buttonSecondaryPrimary.swiftUIColor,
                    textColor: textColor ?? Colors.textDefault.swiftUIColor,
                    pressedColor: pressedColor ?? Colors.buttonSecondaryPress.swiftUIColor,
                    padding: padding ?? defaultPadding,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    height: height ?? defaultHeight,
                    configuration: configuration,
                    font: font
                )
            )
        case .control(let isFilled):
            return AnyView(
                ControlButton(
                    color: color ?? Colors.control1.swiftUIColor,
                    textColor: textColor ?? (isFilled ? Colors.buttonTitle.swiftUIColor : Colors.textDefault.swiftUIColor),
                    pressedColor: pressedColor ?? Colors.buttonSecondaryPress.swiftUIColor,
                    verticalPadding: padding ?? 8,
                    horizontalPadding: padding ?? 12,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    isFilled: isFilled,
                    height: height,
                    configuration: configuration,
                    font: font,
                    shouldExpand: shouldExpand
                )
            )
        case .destructive:
            return AnyView(
                ControlButton(
                    color: color ?? Colors.alert2.swiftUIColor,
                    textColor: textColor ?? .white,
                    pressedColor: pressedColor ?? Colors.alert2.swiftUIColor,
                    verticalPadding: padding ?? 8,
                    horizontalPadding: padding ?? 12,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    isFilled: true,
                    height: height,
                    configuration: configuration,
                    font: font,
                    shouldExpand: shouldExpand
                )
            )
        case .link:
            return AnyView(
                LinkButton(
                    textColor: textColor ?? Colors.gray1.swiftUIColor,
                    padding: padding ?? defaultPadding,
                    cornerRadius: cornerRadius ?? defaultCornerRadius,
                    height: height ?? defaultHeight,
                    configuration: configuration,
                    font: font
                )
            )
        }
    }
    
    // MARK: - FillButton
    
    public struct FillButton: View {
        
        // MARK: - Properties
        
        public var color: Color?
        public var textColor: Color
        public var pressedColor: Color
        public var padding: CGFloat
        public var cornerRadius: CGFloat
        public var height: CGFloat
        public var configuration: ButtonStyle.Configuration
        public var font: Font?
        
        // MARK: - Private
        
        private var pressedGradientColors: [Color] {
            [
                Colors.buttonFilledPress.swiftUIColor
            ]
        }
        
        private var gradientColors: [Color] {
            [
                Colors.buttonFilledPrimary1.swiftUIColor,
                Colors.buttonFilledPrimary2.swiftUIColor,
                Colors.buttonFilledPrimary3.swiftUIColor
            ]
        }
        
        private var disabledGradientColors: [Color] {
            [
                Colors.buttonDisabled.swiftUIColor
            ]
        }
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        // MARK: - View
        
        public var body: some View {
            GeometryReader { proxy in
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .foregroundStyle(
                            LinearGradient(
                                colors: foregroundColors(),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    configuration
                        .label
                        .font(font ?? .inter(size: defaultFontSize, weight: .medium))
                        .foregroundColor(currentTextColor())
                }
                .frame(width: proxy.size.width, height: height)
            }
        }
        
        // MARK: - Usefull
        
        private func foregroundColors() -> [Color] {
            guard isEnabled else { return disabledGradientColors }
            return configuration.isPressed ? pressedGradientColors : gradientColors
        }
        
        private func currentTextColor() -> Color {
            guard isEnabled else { return Colors.gray2.swiftUIColor }
            return configuration.isPressed ? .white : textColor
        }
    }
    
    // MARK: - SecondaryButton
    
    public struct SecondaryButton: View {
        
        // MARK: - Properties
        
        public var color: Color?
        public var textColor: Color
        public var pressedColor: Color
        public var padding: CGFloat
        public var cornerRadius: CGFloat
        public var height: CGFloat
        public var configuration: ButtonStyle.Configuration
        public var font: Font?
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        // MARK: - View
        
        public var body: some View {
            GeometryReader { proxy in
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .foregroundStyle(foregroundColor())
                    configuration
                        .label
                        .font(font ?? .inter(size: defaultFontSize, weight: .medium))
                        .foregroundColor(isEnabled ? textColor : Colors.gray2.swiftUIColor)
                }
                .frame(width: proxy.size.width, height: height)
            }
        }
        
        // MARK: - Usefull
        
        private func foregroundColor() -> Color {
            guard isEnabled else { return Colors.buttonDisabled.swiftUIColor }
            return configuration.isPressed ? Colors.buttonSecondaryPress.swiftUIColor : Colors.buttonSecondaryPrimary.swiftUIColor
        }
    }
    
    // MARK: - OutlineButton
    
    public struct OutlineButton: View {
        
        // MARK: - Properties
        
        public var color: Color?
        public var textColor: Color
        public var pressedColor: Color
        public var padding: CGFloat
        public var cornerRadius: CGFloat
        public var height: CGFloat
        public var configuration: ButtonStyle.Configuration
        public var font: Font?
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        // MARK: - View
        
        public var body: some View {
            GeometryReader { proxy in
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(
                            foregrouColor(),
                            strokeBorder: LinearGradient(
                                colors: strokeColors(),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 1
                        )
                    configuration
                        .label
                        .font(font ?? .inter(size: defaultFontSize, weight: .medium))
                        .foregroundColor(currentTextColor())
                }
                .frame(width: proxy.size.width, height: height)
            }
        }
        
        // MARK: - Usefull
        
        private func strokeColors() -> [Color] {
            guard isEnabled else { return [Colors.buttonDisabled.swiftUIColor] }
            return configuration.isPressed ? [Colors.buttonSecondaryPress.swiftUIColor] : [
                Colors.buttonOutlinePrimary1.swiftUIColor,
                Colors.buttonOutlinePrimary2.swiftUIColor
            ]
        }
        
        private func foregrouColor() -> Color {
            guard isEnabled else { return .clear }
            return configuration.isPressed ? Colors.buttonOutlinePress.swiftUIColor : .clear
        }
        
        private func currentTextColor() -> Color {
            guard isEnabled else { return Colors.buttonDisabled.swiftUIColor }
            return configuration.isPressed ? Colors.buttonSecondaryPress.swiftUIColor : textColor
        }
    }
    
    // MARK: - ControlButton
    
    public struct ControlButton: View {
        
        // MARK: - Properties
        
        public var color: Color?
        public var textColor: Color
        public var pressedColor: Color
        public var verticalPadding: CGFloat
        public var horizontalPadding: CGFloat
        public var cornerRadius: CGFloat
        public var isFilled: Bool
        public var height: CGFloat?
        public var configuration: ButtonStyle.Configuration
        public var font: Font?
        public var shouldExpand: Bool
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        // MARK: - View
        
        public var body: some View {
            HStack(spacing: 0) {
                if shouldExpand {
                    Spacer(minLength: 0)
                }
                configuration
                    .label
                    .font(font ?? .inter(size: defaultFontControlTextSize, weight: .medium))
                    .foregroundColor(textColor)
                if shouldExpand {
                    Spacer(minLength: 0)
                }
            }
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(isFilled ? backgroundColor : .clear)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        .clear,
                        strokeBorder: isFilled ? backgroundColor : Colors.gray2.swiftUIColor,
                        lineWidth: 1
                    )
            )
            .smoothCorners(radius: cornerRadius)
            .animation(nil, value: textColor)
            .contentShape(Rectangle())
        }
        
        // MARK: - Usefull
        
         private var backgroundColor: Color {
            isEnabled ? color ?? Colors.control1.swiftUIColor : Colors.gray2.swiftUIColor
        }
    }
    
    // MARK: - TextButton
    
    public struct TextButton: View {
        
        // MARK: - Properties
        
        public var textColor: Color
        public var padding: CGFloat
        public var cornerRadius: CGFloat
        public var height: CGFloat
        public var configuration: ButtonStyle.Configuration
        public var font: Font?
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        // MARK: - View
        
        public var body: some View {
            configuration
                .label
                .font(font ?? .inter(size: defaultFontTextSize, weight: .medium))
                .foregroundColor(currentTextColor())
                .overlay(
                    Rectangle()
                        .fill(currentTextColor())
                        .frame(height: 1.5)
                        .isOpaque(configuration.isPressed),
                    alignment: .bottom
                )
        }
        
        // MARK: - Useful
        
        private func currentTextColor() -> Color {
            guard isEnabled else { return Colors.buttonDisabled.swiftUIColor }
            return configuration.isPressed ? Colors.buttonSecondaryPress.swiftUIColor : textColor
        }
    }
    
    // MARK: - LinkButton

    public struct LinkButton: View {
        
        // MARK: - Properties
        
        public var textColor: Color
        public var padding: CGFloat
        public var cornerRadius: CGFloat
        public var height: CGFloat
        public var configuration: ButtonStyle.Configuration
        public var font: Font?
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        // MARK: - View

        public var body: some View {
            configuration
                .label
                .font(font ?? .inter(size: defaultFontLinkSize, weight: .medium))
                .foregroundColor(currentTextColor())
                .overlay(
                    Rectangle()
                        .fill(currentTextColor())
                        .frame(height: 1)
                        .offset(y: 3),
                    alignment: .bottom
                )
        }
        
        // MARK: - Useful
        
        private func currentTextColor() -> Color {
            guard isEnabled else { return Colors.buttonDisabled.swiftUIColor }
            return configuration.isPressed ? Colors.gray3.swiftUIColor : textColor
        }
    }
}

// MARK: - DXButton

@WithLocalizationUpdater
public struct DXButton: View {
    
    // MARK: - Aliases
    
    public typealias TextClosure = () -> String?
    
    // MARK: - Style
    
    public enum Style {
        case fill
        case secondary
        case outline
        case control(fill: Bool)
        case destructive
        case text
        case link
    }
    
    // MARK: - Properties
    
    public var text: TextClosure?
    public var lineLimit: Int
    public var leadingImage: Image?
    public var trailingImage: Image?
    public var leadingImageSize: CGFloat = 24
    public var trailingImageSize: CGFloat = 24
    public let leadingImageColor: Color?
    public let trailingImageColor: Color?
    public var style: Style = .fill
    public var color: Color?
    public var displaySpacer: Bool
    public var textColor: Color?
    public var pressedColor: Color?
    public var textAndImage: Bool { text != nil && (leadingImage != nil || trailingImage != nil) }
    public var padding: CGFloat?
    public var cornerRadius: CGFloat?
    public var height: CGFloat
    public var action: () -> Void
    public var font: Font?
    public var shouldExpand: Bool
    public var contentInsets: EdgeInsets
    
    // MARK: - Private
    
    private var shouldDisplaySpacer: Bool {
        switch style {
        case .link, .text: false
        default: displaySpacer
        }
    }
    
    // MARK: - Initializers
    
    /// Initializes a new `DXButton` with the specified properties.
    /// - Parameters:
    ///   - text: A closure that returns the text to be displayed on the button. This can be `nil` if no text is required.
    ///   - leadingImage: An optional image to display on the leading side of the button. The default is `nil`.
    ///   - leadingImageColor: An optional color for the leading image. If `nil`, the image will use its original colors. The default is `nil`.
    ///   - leadingImageSize: The size of the leading image. The default value is 24.
    ///   - trailingImage: An optional image to display on the trailing side of the button. The default is `nil`.
    ///   - trailingImageColor: An optional color for the trailing image. If `nil`, the image will use its original colors. The default is `nil`.
    ///   - trailingImageSize: The size of the trailing image. The default value is 24.
    ///   - style: The style of the button, which determines its appearance. The default is `.fill`.
    ///   - color: The background color of the button. The default is `nil`.
    ///   - textColor: The color of the text in the button. The default is `nil`.
    ///   - pressedColor: The color of the button when it is pressed. The default is `nil`.
    ///   - padding: The padding around the content of the button. The default is `nil`.
    ///   - cornerRadius: The corner radius of the button. The default is `nil`.
    ///   - height: The height of the button. The default value is 40.
    ///   - font: The font of the text in the button. The default is `nil`.
    ///   - displaySpacer: A Boolean value indicating whether to display spacers around the content. The default is `true`.
    ///   - action: A closure that is executed when the button is tapped.
    public init(
        text: @autoclosure @escaping TextClosure,
        lineLimit: Int = 0,
        leadingImage: Image? = nil,
        leadingImageColor: Color? = nil,
        leadingImageSize: CGFloat = 24,
        trailingImage: Image? = nil,
        trailingImageColor: Color? = nil,
        trailingImageSize: CGFloat = 24,
        style: Style = .fill,
        color: Color? = nil,
        textColor: Color? = nil,
        pressedColor: Color? = nil,
        padding: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        height: CGFloat = 50,
        font: Font? = nil,
        displaySpacer: Bool = true,
        shouldExpand: Bool = false,
        contentInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
        action: @escaping () -> Void
    ) {
        self.text = text
        self.lineLimit = lineLimit
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.leadingImageSize = leadingImageSize
        self.trailingImageSize = trailingImageSize
        self.leadingImageColor = leadingImageColor
        self.trailingImageColor = trailingImageColor
        self.color = color
        self.style = style
        self.textColor = textColor
        self.pressedColor = pressedColor
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.height = height
        self.action = action
        self.font = font
        self.shouldExpand = shouldExpand
        self.displaySpacer = displaySpacer
        self.contentInsets = contentInsets
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            Button(action: action, label: {
                HStack {
                    if shouldDisplaySpacer {
                        Spacer()
                    }
                    HStack(spacing: textAndImage ? 8 : 0) {
                        leadingImage?
                            .renderingMode(leadingImageColor == nil ? .original : .template)
                            .scaledImage(with: .fit, size: leadingImageSize)
                            .foregroundColor(leadingImageColor)
                        Text(text?() ?? "")
                            .lineLimit(lineLimit)
                        trailingImage?
                            .renderingMode(trailingImageColor == nil ? .original : .template)
                            .scaledImage(with: .fit, size: trailingImageSize)
                            .foregroundColor(trailingImageColor)
                    }
                    if shouldDisplaySpacer {
                        Spacer()
                    }
                }
                .padding(contentInsets)
                .fixedSize()
                .contentShape(Rectangle())
            })
            .style(
                style,
                color: color,
                textColor: textColor,
                pressedColor: pressedColor,
                padding: padding,
                cornerRadius: cornerRadius,
                height: height,
                font: font,
                shouldExpand: shouldExpand
            )
            .frame(height: height)
        }
    }
}

// MARK: - DXDialogButtonType + DXDialog

extension DXButton {
    
    public init(
        type: DXDialogButtonType,
        action: @escaping VoidClosure
    ) {
        self.init(
            text: type.title,
            leadingImage: type.leadingImage,
            style: type.style,
            font: .inter(size: 18, weight: .medium),
            shouldExpand: true,
            action: action
        )
    }
}

// MARK: - Button

public extension Button {
    
    /// Changes the appearance of the button
    func style(
        _ style: DXButton.Style,
        color: Color?,
        textColor: Color?,
        pressedColor: Color?,
        padding: CGFloat?,
        cornerRadius: CGFloat?,
        height: CGFloat,
        font: Font?,
        shouldExpand: Bool
    ) -> some View {
        self.buttonStyle(
            DXButtonStyle(
                color: color,
                textColor: textColor,
                pressedColor: pressedColor,
                padding: padding,
                cornerRadius: cornerRadius,
                height: height,
                style: style,
                font: font,
                shouldExpand: shouldExpand
            )
        )
    }
}

// MARK: - Preview

#Preview {
    List {
        Section("Fill button") {
            HStack {
                DXButton(text: "Default", style: .fill) {
                    print("Test")
                }
                DXButton(
                    text: "Default",
                    leadingImage: Image(systemName: "plus"),
                    style: .fill
                ) {
                    print("Test")
                }
            }
            DXButton(text: "Disabled", style: .fill) {
                print("Test")
            }
            .disabled(true)
        }
        Section("Secondary button") {
            HStack {
                DXButton(text: "Default", style: .secondary) {
                    print("Test")
                }
                DXButton(
                    text: "Default",
                    leadingImage: Image(systemName: "plus"),
                    style: .secondary
                ) {
                    print("Test")
                }
            }
            DXButton(text: "Disabled", style: .secondary) {
                print("Test")
            }
            .disabled(true)
        }
        Section("Outline button") {
            HStack {
                DXButton(text: "Default", style: .outline) {
                    print("Test")
                }
                DXButton(
                    text: "Default",
                    leadingImage: Image(systemName: "plus"),
                    style: .outline
                ) {
                    print("Test")
                }
            }
            DXButton(text: "Disabled", style: .outline) {
                print("Test")
            }
            .disabled(true)
        }
        Section("Control button") {
            HStack {
                DXButton(text: "Control filled", style: .control(fill: true)) {
                    print("Control")
                }
                DXButton(text: "Control unfilled", style: .control(fill: false)) {
                    print("Control")
                }
            }
        }
        Section("Text button") {
            HStack {
                Spacer()
                DXButton(text: "Default", style: .text) {
                    print("Test")
                }
                Spacer()
                DXButton(
                    text: "Default",
                    leadingImage: Image(systemName: "plus"),
                    style: .text
                ) {
                    print("Test")
                }
                Spacer()
            }
            HStack {
                Spacer()
                DXButton(text: "Disabled", style: .text) {
                    print("Test")
                }
                .disabled(true)
                Spacer()
            }
        }
    }
    .listStyle(.plain)
}
