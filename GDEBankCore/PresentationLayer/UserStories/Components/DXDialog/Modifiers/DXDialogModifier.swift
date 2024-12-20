//
//  DXDialogModifier.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 01.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit
@_spi(Presentation) import ComposableArchitecture

// MARK: - DXDialogModifier

public struct DXDialogModifier: ViewModifier {

    // MARK: - Properties
    
    /// Dialog presenation mode
    private let presenationMode: DXDialogPresentationMode
    
    /// Dialog store
    public var store: Binding<StoreOf<DXDialog>?>
    
    @Shared(.useDarkTheme)
    public var useDarkTheme = false
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///   - presenationMode: Dialog presenation mode
    ///   - navigationTitle: Navigation title
    ///   - store: dialog store
    public init(
        presenationMode: DXDialogPresentationMode,
        store: Binding<StoreOf<DXDialog>?>
    ) {
        self.presenationMode = presenationMode
        self.store = store
    }

    // MARK: - ViewModifier

    public func body(content: Content) -> some View {
        switch presenationMode {
        case .fullScreenCover:
            content
                .fullScreenCover(item: store) { itemStore in
                    NavigationStack {
                        dialogView(store: itemStore)
                            .padding(.top, presenationMode.topPadding)
                            .padding(.horizontal, presenationMode.horizontalPaddings)
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    if itemStore.showCloseButton {
                                        closeButtonView
                                    }
                                }
                            }
                    }
                    .environment(\.colorScheme, useDarkTheme ? .dark : .light)
                    .withPulseLogging()
                }
        case .popup:
            ZStack {
                content
                    .blur(radius: store.wrappedValue == nil ? 0 : 3)
                    .padding(.top, store.wrappedValue == nil ? 0 : -6) /// SwiftUI bug when blure applied view go down little
                    .animation(nil, value: store.wrappedValue == nil)
                if let itemStore = store.wrappedValue {
                    CoreColors.bg3.swiftUIColor.opacity(0.6)
                    dialogView(store: itemStore)
                        .overlay(alignment: .topTrailing) {
                            if itemStore.showCloseButton {
                                closeButtonView
                            }
                        }
                        .padding(.top, presenationMode.topPadding)
                        .padding(.horizontal, presenationMode.horizontalPaddings)
                        .transition(.opacity)
                }
            }
            .animation(.easeIn(duration: 0.24), value: store.wrappedValue == nil)
            .environment(\.colorScheme, useDarkTheme ? .dark : .light)
        }
    }
    
    // MARK: - Subviews
    
    private func dialogView(store: StoreOf<DXDialog>) -> some View {
        DXDialogView(
            store: store,
            appearance: presenationMode.appereance
        )
    }
    
    private var closeButtonView: some View {
        Button {
            store.wrappedValue?.send(.closeButtonTapped)
            store.wrappedValue = nil
        } label: {
            CoreAssets.close.swiftUIImage
                .scaledImage(with: .fit, size: 24)
        }
        .padding([.top, .trailing], presenationMode.appereance.closeButtonPaddings ?? 0)
    }
}

// MARK: View

extension View {
    
    /// Presents a sheet using the given store as a data source for the sheet's content.
    ///
    /// > This is a Composable Architecture-friendly version of SwiftUI's `sheet` view modifier.
    ///
    /// - Parameters:
    ///   - store: A store that is focused on ``PresentationState`` and ``PresentationAction`` for
    ///     a modal. When `store`'s state is non-`nil`, the system passes a store of unwrapped `State`
    ///     and `Action` to the modifier's closure. You use this store to power the content in a sheet
    ///     you create that the system displays to the user. If `store`'s state is `nil`-ed out, the
    ///     system dismisses the currently displayed sheet.
    public func dxDialog(
        store: Binding<StoreOf<DXDialog>?>,
        presenationMode: DXDialogPresentationMode = .popup
    ) -> some View {
        modifier(
            DXDialogModifier(
                presenationMode: presenationMode,
                store: store
            )
        )
    }
    
    /// Presents a sheet using the given store as a data source for the sheet's content.
    ///
    /// > This is a Composable Architecture-friendly version of SwiftUI's `sheet` view modifier.
    ///
    /// - Parameters:
    ///   - store: A store that is focused on ``PresentationState`` and ``PresentationAction`` for
    ///     a modal. When `store`'s state is non-`nil`, the system passes a store of unwrapped `State`
    ///     and `Action` to the modifier's closure. You use this store to power the content in a sheet
    ///     you create that the system displays to the user. If `store`'s state is `nil`-ed out, the
    ///     system dismisses the currently displayed sheet.
    public func dxPopupDialog(
        store: Binding<StoreOf<DXDialog>?>
    ) -> some View {
        modifier(
            DXDialogModifier(
                presenationMode: .popup,
                store: store
            )
        )
    }
    
    /// Presents a sheet using the given store as a data source for the sheet's content.
    ///
    /// > This is a Composable Architecture-friendly version of SwiftUI's `sheet` view modifier.
    ///
    /// - Parameters:
    ///   - store: A store that is focused on ``PresentationState`` and ``PresentationAction`` for
    ///     a modal. When `store`'s state is non-`nil`, the system passes a store of unwrapped `State`
    ///     and `Action` to the modifier's closure. You use this store to power the content in a sheet
    ///     you create that the system displays to the user. If `store`'s state is `nil`-ed out, the
    ///     system dismisses the currently displayed sheet.
    public func dxFullScreenDialog(
        store: Binding<StoreOf<DXDialog>?>
    ) -> some View {
        modifier(
            DXDialogModifier(
                presenationMode: .fullScreenCover,
                store: store
            )
        )
    }
}
