//
//  CornerPin.swift
//  Chibiverse
//
//  Created by Dmitry Savinov on 24.08.2024.
//

import SwiftUI

// MARK: - View

extension View {
    
    /// Pins view to given corner
    /// - Parameter corner: target corner
    /// - Returns: modified view pinned to given corner
    public func pin(_ corner: CornerPin.Corner) -> some View {
        modifier(CornerPin(corner: corner))
    }
}

// MARK: - CornerPin

public struct CornerPin: ViewModifier {
    
    // MARK: - Corner
    
    public enum Corner {
        
        // MARK: - HorizontalAligment
        
        public enum HorizontalAligment {
            case left
            case right
            case center
            case none
        }
        
        // MARK: - Cases
        
        case top(HorizontalAligment)
        case bottom(HorizontalAligment)
        
        case left
        case right
    }
    
    // MARK: - Properties
    
    /// The target corner
    public let corner: Corner
    
    // MARK: - ViewModifier
    
    public func body(content: Content) -> some View {
        switch corner {
        case .top(let horizontalAligment):
            VStack(spacing: 0) {
                content
                    .modifier(HorizontalAligner(aligment: horizontalAligment))
                Spacer(minLength: 0)
            }
            
        case .bottom(let horizontalAligment):
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                content
                    .modifier(HorizontalAligner(aligment: horizontalAligment))
            }
        case .left:
            content
                .modifier(HorizontalAligner(aligment: .left))
        case .right:
            content
                .modifier(HorizontalAligner(aligment: .right))
        }
    }
}

// MARK: - HorizontalPin

private struct HorizontalAligner: ViewModifier {
    
    // MARK: - Properties
    
    /// The target horizontal aligment
    let aligment: CornerPin.Corner.HorizontalAligment
    
    // MARK: - ViewModifier
    
    func body(content: Content) -> some View {
        switch aligment {
        case .left:
            HStack(spacing: 0) {
                content
                Spacer(minLength: 0)
            }
        case .right:
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                content
            }
        case .center:
            content
                .centered()
        case .none:
            content
        }
    }
}

