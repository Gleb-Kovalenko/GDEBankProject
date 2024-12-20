//
//  View.swift
//  Reviews
//
//  Created by Dmitry Savinov on 13.08.2024.
//

import SwiftUI
import Foundation
import ComposableArchitecture

// MARK: - View

extension View {
    
    /// Positions this view within an invisible frame with the specified size.
    /// - Parameter size: A fixed `width` and `height` for the resulting view
    /// - Returns: A view with fixed dimensions of `widht` and `height`
    public func frame(size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
    
    /// View type erase 
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    /// Positions this view within an invisible frame with the specified size.
    public func frame(size: CGFloat, aligment: Alignment = .center) -> some View {
        self.frame(width: size, height: size, alignment: aligment)
    }
    
    public func dxShadow() -> some View {
        shadow(color: Colors.shadowDefault.swiftUIColor, radius: 8, x: 0, y: 4)
    }
    
    public func isOpaque(_ isActive: Bool) -> some View {
        opacity(isActive ? 1 : 0)
    }
    
    public func lineLimited(lineLimit: Int = 1, minimumScaleFactor: CGFloat = 0.6) -> some View {
        self
            .lineLimit(lineLimit)
            .minimumScaleFactor(minimumScaleFactor)
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder public func when<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder public func navigationLink<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        background(
            NavigationLink(
                isActive: isActive,
                destination: destination,
                label: {
                    EmptyView()
                }
            )
        )
    }
    
    @ViewBuilder
    func fixedOnChange<Value: Equatable>(of value: Value, result: @escaping (Value) -> ()) -> some View {
        if #available(iOS 17, *) {
            self
                .onChange(of: value) { _, newValue in
                    result(newValue)
                }
        } else {
            self
                .onChange(of: value, perform: { value in
                    result(value)
                })
        }
    }
}
