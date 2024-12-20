//
//  WIPView.swift
//  GDEBank
//
//  Created by incetro on 12/7/23.
//

import SwiftUI

// MARK: - WIPView

struct WIPView: View {
    
    // MARK: - Properties
    
    /// Current presentation mode
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 12) {
                Spacer()
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 100,
                        height: 100
                    )
                    .padding(.bottom, 20)
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                Text("Work in progress")
                    .font(.inter(size: 25, weight: .bold))
                    .padding(.horizontal, 16)
                Text("We are working on this feature now 🩵")
                    .font(.inter(size: 17, weight: .regular))
                    .padding(.horizontal, 16)
                    .padding(.top, 4)
                Spacer()
                DXButton(
                    text: "Good",
                    color: .accentColor,
                    textColor: .white,
                    pressedColor: Colors.accentPressed.swiftUIColor
                ) {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.horizontal, 16)
                .padding(.top, 50)
            }
        }
    }
}

// MARK: - WIPView

#Preview {
    Color.black
        .sheet(isPresented: .constant(true)) {
            WIPView()
        }
}
