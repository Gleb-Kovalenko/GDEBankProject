//
//  PayLoginView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit
import GDEBankCore

// MARK: - PayLoginView

@WithLocalizationUpdater
public struct PayLoginView: View {
    
    // MARK: - Properties

    /// The store powering the `PayLogin` reducer
    public let store: StoreOf<PayLogin>
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                Color
                    .defaultPrimary
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(Assets.gdeBankIntro.name)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    DXButton(
                        text: L10n.Intro.connect,
                        style: .fill,
                        action: {
                            store.send(.connectButtonTapped)
                        }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PayLoginView(
        store: Store(
            initialState: PayLoginState(),
            reducer: { PayLogin() }
        )
    )
}
