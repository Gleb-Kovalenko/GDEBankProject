//
//  View+Bind.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 18.08.24.
//

import Foundation
import SwiftUI

// MARK: - View

extension View {
    func bind<Value>(
        _ first: Binding<Value>,
        _ second: FocusState<Value>.Binding
    ) -> some View {
        self
            .onChange(of: first.wrappedValue) { second.wrappedValue = $0 }
            .onChange(of: second.wrappedValue) { first.wrappedValue = $0 }
    }
}
