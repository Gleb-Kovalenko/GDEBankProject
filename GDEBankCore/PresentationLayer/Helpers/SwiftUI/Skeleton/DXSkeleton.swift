//
//  DXSkeleton.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import SwiftUI
import SkeletonUI

// MARK: - View

extension View {
    
    public func dxSkeleton(
        with loading: Bool = true,
        size: CGSize? = .none,
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        transition: (type: AnyTransition, animation: Animation?) = (.opacity, .default),
        animation: AnimationType = .pulse(duration: 3, speed: 2.5),
        appearance: AppearanceType = .gradient(.linear, color: Colors.bg3.swiftUIColor, background: Colors.bg4.swiftUIColor),
        shape: ShapeType = .capsule,
        lines: Int = 1,
        scales: [Int: CGFloat]? = .none,
        spacing: CGFloat? = .none
    ) -> some View {
        self.skeleton(
            with: loading,
            size: size,
            transition: transition,
            animation: animation,
            appearance: appearance,
            shape: shape,
            lines: lines,
            scales: scales,
            spacing: spacing
        )
    }
    
    public func dxSkeletonAnimation<Value: Equatable>(value: Value) -> some View {
        animation(.easeIn(duration: 0.2), value: value)
    }
}
