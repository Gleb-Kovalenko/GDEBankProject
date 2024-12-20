//
//  ViewAllButtonView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 15.08.2024.
//

import SwiftUI

// MARK: - ViewAllButtonView

public struct ViewAllButton: View {
    
    // MARK: - Mode
    
    public enum Mode {
        
        // MARK: - Cases
        
        case large
        case small
        
        // MARK: - Useful
        
        public var cornerRadius: CGFloat {
            switch self {
            case .large: 18
            case .small: 21
            }
        }
    }
    
    // MARK: - Properties
    
    /// View mode
    public let mode: Mode
    
    /// On card tapped action
    public let action: VoidClosure
    
    // MARK: - View
    
    public var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 0) {
                if mode == .large {
                    Spacer(minLength: 0)
                }
                HStack(spacing: 4) {
                    if mode == .large {
                        Spacer(minLength: 0)
                    }
                    Text("Button all")
                        .font(.inter(size: 17, weight: .semibold))
                        .foregroundColor(.accentColor)
                    Image(systemName: "chevron.right")
                        .font(.inter(size: 13, weight: .semibold))
                        .foregroundColor(.accentColor)
                    if mode == .large {
                        Spacer(minLength: 0)
                    }
                }
                if mode == .large {
                    Spacer(minLength: 0)
                }
            }
            .padding(.vertical, 4.5)
            .padding(.horizontal, 16)
            .background(Colors.bg4.swiftUIColor)
            .smoothCorners(radius: mode.cornerRadius)
        }
    }
}

#Preview {
    ZStack {
        Colors.bg1.swiftUIColor
        ViewAllButton(mode: .large) {
            
        }
    }
}
