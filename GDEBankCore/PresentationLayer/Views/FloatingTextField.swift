//
//  FloatingTextField.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import SwiftUI

// MARK: -  FloatingTextField

public struct FloatingTextField: View {

    // MARK: - Properties

    private let textFieldHeight: CGFloat
    private let placeHolderText: String
    @Binding var text: String
    @State private var isEditing = false
    @State private var failureAttemptsCount = 0
    private var keyboardType: UIKeyboardType
    private let regularExpression: NSRegularExpression?

    var shouldPlaceHolderMove: Bool {
        isEditing || text.count != 0
    }

    // MARK: - Initializers

    public init(
        placeHolder: String,
        text: Binding<String>,
        textFieldHeight: CGFloat? = nil,
        keyboardType: UIKeyboardType = .default,
        fontColor: Color = Colors.textDefault.swiftUIColor,
        regularExpression: NSRegularExpression? = nil
    ) {
        self._text = text
        self.placeHolderText = placeHolder
        self.keyboardType = keyboardType
        if let textFieldHeight {
            self.textFieldHeight = textFieldHeight
        } else {
            self.textFieldHeight = Constants.defaultTextFieldHeight
        }
        self.regularExpression = regularExpression
    }

    // MARK: - View

    public var body: some View {
        ZStack(alignment: .leading) {
            ///Floating Placeholder
            Text(placeHolderText)
                .font(.inter(size: 12, weight: .regular))
                .foregroundColor(Colors.textGray.swiftUIColor)
                .multilineTextAlignment(.leading)
                .padding(.bottom, shouldPlaceHolderMove ? textFieldHeight / 2 : 0)
                .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.3, anchor: UnitPoint(x: 0, y: 1))
                .animation(.easeInOut(duration: 0.25))
            TextField(
                "",
                text: Binding(
                    get: { text },
                    set: validate
                ),
                onEditingChanged: { edit in
                    isEditing = edit
                }
            )
            .multilineTextAlignment(.leading)
            .foregroundColor(Colors.textDefault.swiftUIColor)
            .keyboardType(keyboardType)
            .padding(.top, textFieldHeight / 3)
            .modifier(ShakeEffect(amount: 2.5, animatableData: CGFloat(failureAttemptsCount)))
            .animation(.easeInOut(duration: 0.2), value: failureAttemptsCount)
        }
    }
    
    // MARK: - Private
    
    private func validate(string: String) {
        guard let regularExpression, !string.isEmpty, !regularExpression.matches(string) else {
            text = string
            return
        }
        /// Below code prevented sui binding bug
        let oldText = text
        text = text + " "
        text = oldText
        failureAttemptsCount += 1
    }
}

// MARK: - Constants

extension FloatingTextField {

    public enum Constants {
        static let defaultTextFieldHeight: CGFloat = 50
    }
}
