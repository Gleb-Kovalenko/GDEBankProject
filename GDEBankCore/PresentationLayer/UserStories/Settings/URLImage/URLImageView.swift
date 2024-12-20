//
//  URLImageView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 6.08.24.
//

import ComposableArchitecture
import SwiftUI
import Kingfisher

// MARK: - URLImageView

/// A visual representation of `URLImage` module.
/// Here we define the view that displays the feature.
/// It holds onto a `Store<URLImageState, URLImageAction>` so that it can observe
/// all changes to the state and re-render, and we can send all user actions
/// to the store so that state changes.
public struct URLImageView<Placeholder: View>: View {

    // MARK: - Properties

    /// `URLImage` module `Store` instance
    private let store: StoreOf<URLImageReducer>

    /// Target placeholder view
    private let placeholder: Placeholder?

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - store: URLImageStore instance
    public init(store: StoreOf<URLImageReducer>, @ViewBuilder placeholder: @escaping () -> Placeholder? = { nil }) {
        self.store = store
        self.placeholder = placeholder()
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(store) { viewStore in
            KFImage(viewStore.url)
            .requestModifier(
                AnyModifier { request in
                    var request = request
                    request.setValue("Bearer " + (viewStore.accessToken ?? ""), forHTTPHeaderField: "Authorization")
                    return request
                }
            )
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .placeholder {
                if let placeholder {
                    placeholder
                } else {
                    viewStore.placeholderImage
                }
            }
            .onSuccess { result in
                viewStore.send(.imageDataObtained)
            }
            .resizable()
            .scaledToFill()
            .onAppear {
                viewStore.send(.onAppear)
            }
            .id(viewStore.url)
        }
    }
}
