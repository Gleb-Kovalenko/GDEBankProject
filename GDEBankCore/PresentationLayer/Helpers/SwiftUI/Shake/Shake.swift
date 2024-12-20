//
//  Shake.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import SwiftUI

// MARK: - Shake

public struct ShakeEffect: GeometryEffect {
    
    // MARK: - Properties
    
    public var amount: CGFloat = 7
    public var shakesPerUnit = 7
    public var animatableData: CGFloat

    // MARK: - GeometryEffect

    public func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}

// MARK: - View

public extension View {
    func shake(when trigger: Binding<Bool>) -> some View {
        modifier(ShakeModifier(trigger: trigger))
    }
}

public struct ShakeModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var trigger: Bool
    @State private var shakeAnimation: CGFloat = 0
    
    // MARK: - ViewModifier
    
    public func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(animatableData: shakeAnimation))
            .onChange(of: trigger) { newValue in
                if newValue {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        shakeAnimation = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        shakeAnimation = 0
                        trigger = false
                    }
                }
            }
    }
}
