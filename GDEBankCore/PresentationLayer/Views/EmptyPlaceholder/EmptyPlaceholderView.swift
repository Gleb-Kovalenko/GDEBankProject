//
//  EmptyPlaceholderView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - EmptyPlaceholderView

@WithLocalizationUpdater
public struct EmptyPlaceholderView: View {
    
    // MARK: - Properties
    
    /// The store powering the `EmptyPlaceholder` feature
    public let store: StoreOf<EmptyPlaceholderReducer>
    
    // MARK: - View
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 12) {
                Spacer()
                if let imageName = viewStore.imageName {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 100,
                            height: 100
                        )
                        .padding(.bottom, 20)
                        .foregroundColor(.accentColor)
                }
                Text(LocalizedStringKey(viewStore.localizedTitleKey))
                    .font(.inter(size: 25, weight: .bold))
                    .padding(.horizontal, 24)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                Text(LocalizedStringKey(viewStore.localizedSubtitleKey))
                    .font(.inter(size: 17, weight: .regular))
                    .padding(.horizontal, 24)
                    .padding(.top, 4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.textGray.swiftUIColor)
                Spacer()
                if let localizedActionButtonKey = viewStore.localizedActionButtonKey {
                    DXButton(
                        text: localizedActionButtonKey,
                        color: .accentColor,
                        textColor: .white,
                        pressedColor: Colors.accentPressed.swiftUIColor
                    ) {
                        viewStore.send(.actionButtonTapped)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .padding(.top, 50)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    EmptyPlaceholderView(
        store: Store(
            initialState: EmptyPlaceholderState(
                imageName: "heart.fill",
                localizedTitleKey: "No favorite articles",
                localizedSubtitleKey: "Add your favorite articles by tapping the button below",
                localizedActionButtonKey: "Let's try"
            ), 
            reducer: {
                EmptyPlaceholderReducer()
            }
        )
    )
}
