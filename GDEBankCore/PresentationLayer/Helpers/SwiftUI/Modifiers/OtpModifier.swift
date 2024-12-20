//
//  OPTModifier.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 18.08.24.
//

import Foundation
import SwiftUI
import Combine

// MARK: - OtpModifier

public struct OtpModifier: ViewModifier {
    
    // MARK: - View
    
    public func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .foregroundColor(Colors.textDefault.swiftUIColor)
            .frame(width: 44, height: 50)
            .font(.inter(size: 20, weight: .regular))
            .background(Colors.bg2.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
