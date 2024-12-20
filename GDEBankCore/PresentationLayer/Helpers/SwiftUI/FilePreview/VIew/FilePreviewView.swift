//
//  FilePreviewView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - FilePreviewView

public struct FilePreviewView: View {
    
    // MARK: - Properties

    /// The store powering the `FilePreview` reducer
    public let store: StoreOf<FilePreview>
    
    // MARK: - Initializers
    
    /// Default initializer
    public init(store: StoreOf<FilePreview>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                ZStack {
                    if store.isRemotingOperation {
                        LoaderView(appearance: .medium)
                    } else if let localFileURL = store.localFileURL {
                        QuickLookFileView(localFileURL: localFileURL)
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button {
                                        store.send(.shareSheetButtonTapped)
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                }
                            }
                            .alert(store: store.scope(state: \.$alert, action: \.alert))
                            .shareSheet(store.scope(state: \.shareSheet), dismiss: .shareSheetDismiss)
                    } else if store.isNoFileObtained {
                        Text(L10n.General.cannotObtainFile)
                            .font(.title)
                    }
                }
                .alert(store: store.scope(state: \.$alert, action: \.alert))
                .onAppear {
                    store.send(.onAppear)
                }
                .onDisappear {
                    store.send(.onDisappear)
                }
            }
        }
    }
}
