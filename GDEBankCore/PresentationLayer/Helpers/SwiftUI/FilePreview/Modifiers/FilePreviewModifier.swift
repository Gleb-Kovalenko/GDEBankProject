//
//  FilePreviewModifier.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 06.12.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit
@_spi(Presentation) import ComposableArchitecture

// MARK: - FilePreviewModifier

public struct FilePreviewModifier: ViewModifier {

    // MARK: - Properties
    
    /// Dialog store
    public var store: Binding<StoreOf<FilePreview>?>
    
    @Shared(.useDarkTheme)
    public var useDarkTheme = false
    
    // MARK: - Initializers
    
    /// Default initializer
    public init(
        store: Binding<StoreOf<FilePreview>?>
    ) {
        self.store = store
    }

    // MARK: - ViewModifier

    public func body(content: Content) -> some View {
        content
            .sheet(item: store) { wrapped in
                NavigationStack {
                    FilePreviewView(
                        store: wrapped
                    )
                }
                .environment(\.colorScheme, useDarkTheme ? .dark : .light)
                .withPulseLogging()
            }
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
    public func filePreview(
        store: Binding<StoreOf<FilePreview>?>
    ) -> some View {
        modifier(
            FilePreviewModifier(
                store: store
            )
        )
    }
}
