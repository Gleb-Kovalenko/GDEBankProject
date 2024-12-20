//
//  DXSuccessView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 25.01.2024.
//

import SwiftUI

// MARK: - DXSuccessView

public struct DXSuccessView: View {
    
    // MARK: - Properties
    
    public var title: LocalizedStringKey
    
    public var action: VoidClosure
    
    // MARK: - View
    
    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("checkLarge")
                .padding(.mediumPadding)
            Text(title)
                .font(.inter(size: 22, weight: .semibold))
            Spacer()
            DXButton(text: "Done") {
                action()
            }
        }
    }
}

#Preview {
    DXSuccessView(
        title: LocalizedStringKey(stringLiteral: "15% discount"),
        action: {}
    )
}
