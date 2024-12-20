//
//  ForceUpdateView.swift
//  GDEBank
//
//  Created by incetro on 29/05/2022.
//  Copyright © 2022 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import SwiftMacrosKit

// MARK: - ForceUpdateView

/// A visual representation of `ForceUpdate` module.
/// Here we define the view that displays the feature.
/// It holds onto a `Store<ForceUpdateState, ForceUpdateAction>` so that it can observe
/// all changes to the state and re-render, and we can send all user actions
/// to the store so that state changes.
@WithLocalizationUpdater
public struct ForceUpdateView: View {

    // MARK: - Properties
    
    /// Current presentation mode of the view
    @Environment(\.presentationMode) var presentationMode

    /// `ForceUpdate` module `Store` instance
    private let store: StoreOf<ForceUpdateFeature>

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - store: ForceUpdateStore instance
    public init(store: StoreOf<ForceUpdateFeature>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                Colors.bg2.swiftUIColor
                    .edgesIgnoringSafeArea(.all)
                if viewStore.isSoft {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.hex("#8A8A8F"))
                                    .padding(16)
                            }
                        }
                        Spacer()
                    }
                }
                VStack {
                    Spacer()
                    Image(Assets.appIconLarge.name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                    Text(viewStore.title)
                        .font(.inter(size: 22, weight: .bold))
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 24)
                    Text(viewStore.description)
                        .font(.inter(size: 17, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.bottom)
                    Spacer()
                    DXButton(text: viewStore.buttonTitle) {
                        viewStore.send(.updateButtonTapped)
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom)
                }
            }
        }
    }
}
