//
//  DXSheetModifier.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 30.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - DXSheetModifier

/// A view modifier that presents a sheet with a given content view and manages its dismissal.
///
/// This modifier is designed to integrate with the Composable Architecture by providing
/// a way to display a sheet that can be populated with content derived from a `Store`.
/// It also allows for a dismiss action to be sent to the store when the sheet is closed.
///
/// - Parameters:
///   - State: The state type associated with the store.
///   - Action: The action type associated with the store.
///   - SheetContent: The type of the view to be presented in the sheet.
public struct DXSheetModifier<State, Action, SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    /// A binding to an optional `Store` instance that powers the sheet's content.
    public var store: Binding<Store<State, Action>?>
    
    /// A closure that takes a `Store` and returns the content view for the sheet.
    public let sheetContent: (Store<State, Action>) -> SheetContent
    
    /// Detends
    public let detends: Set<PresentationDetent>
    
    /// The action to be sent to the store when the sheet is dismissed.
    public let dismissAction: Action
    
    /// Navigation title
    public let navigationTitle: String?
    
    /// The current color scheme environment value.
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - ViewModifier
    
    /// The body of the view modifier that describes the view's layout and behavior.
    ///
    /// - Parameter content: The content view to which the modifier is applied.
    /// - Returns: A view that presents a sheet when the store is non-nil.
    public func body(content: Content) -> some View {
        content
            .sheet(item: store) { store in
                NavigationStack {
                    WithPerceptionTracking {
                        sheetContent(store)
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button {
                                        store.send(dismissAction)
                                    } label: {
                                        CoreAssets.close.swiftUIImage
                                            .dxImage(
                                                size: 24,
                                                color: CoreColors.gray2.swiftUIColor
                                            )
                                    }
                                }
                            }
                    }
                    .when(navigationTitle != nil) { content in
                        content
                            .padding(.top, 12)
                            .navigationTitle(navigationTitle ?? "")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .presentationDragIndicator(.automatic)
                .presentationDetents(detends)
                .environment(\.colorScheme, colorScheme)
                .withPulseLogging()
            }
    }
}

// MARK: - View

extension View {
    
    /// Presents a sheet using the specified store, dismiss action, and content view.
    ///
    /// This method applies the `DXSheetModifier` to the view, enabling the display of a sheet
    /// populated with content derived from a `Store`. The sheet can be dismissed by sending
    /// an action to the store.
    ///
    /// - Parameters:
    ///   - store: A binding to an optional `Store` instance that powers the sheet's content.
    ///   - dismissAction: The action to be sent to the store when the sheet is dismissed.
    ///   - content: A closure that takes a `Store` and returns the content view for the sheet.
    /// - Returns: A view that presents a sheet when the store is non-nil.
    public func dxSheet<State, Action, SheetContent: View>(
        store: Binding<Store<State, Action>?>,
        detends: Set<PresentationDetent> = [.large],
        dismissAction: Action,
        navigationTitle: String? = nil,
        content: @escaping (Store<State, Action>) -> SheetContent
    ) -> some View {
        modifier(
            DXSheetModifier(
                store: store,
                sheetContent: content,
                detends: detends,
                dismissAction: dismissAction,
                navigationTitle: navigationTitle
            )
        )
    }
}
