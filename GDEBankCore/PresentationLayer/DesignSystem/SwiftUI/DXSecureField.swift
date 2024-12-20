//
//  DXSecureField.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import Foundation
import SwiftUI

// MARK: - DXSecureField

public struct DXSecureField: View {

    // MARK: - Properties

    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String

    // MARK: - Initializers

    public init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }

    // MARK: - View

    public var body: some View {
        DXRowContainer {
            ZStack(alignment: .trailing) {
                Group {
                    if isSecured {
                        SecureField(title, text: $text)
                    } else {
                        TextField(title, text: $text)
                    }
                }
//                Button(action: {
//                    isSecured.toggle()
//                }) {
//                    Image(systemName: isSecured ? "eye.slash" : "eye")
//                }
//                .buttonStyle(PlainButtonStyle())
//                .foregroundColor(.accent)
            }
        }
    }
}
