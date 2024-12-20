//
//  PayTransferIntroView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit
import GDEBankCore

// MARK: - PayTransferIntroView

@WithLocalizationUpdater
public struct PayTransferIntroView: View {
    
    // MARK: - Properties

    /// The store powering the `PayTransferIntro` reducer
    public let store: StoreOf<PayTransferIntro>
    
    /// Appearance settings for `PayTransferIntroView`.
    public let appearance: PayTransferIntroViewAppearance

    // MARK: - Initializers
    
    /// Initializes the `PayTransferIntroView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `PayTransferIntro` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<PayTransferIntro>,
        appearance: PayTransferIntroViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    /// Initializes the `PayTransferIntroView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `PayTransferIntro` reducer.
    public init(store: StoreOf<PayTransferIntro>) {
        self.store = store
        self.appearance = .default
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)
                    CircledImage(
                        imageName: CoreAssets.scan.name,
                        imageSize: 28,
                        circleSize: 56,
                        circleColor: CoreColors.control1.swiftUIColor,
                        imageColor: .white
                    )
                    VStack(spacing: 8) {
                        Text(store.l10n.title)
                            .font(appearance.titleFont)
                        Text(store.l10n.subtitle)
                            .font(appearance.subtitleFont)
                            .foregroundStyle(appearance.subtitleColor)
                            .multilineTextAlignment(.center)
                    }
                    Spacer(minLength: 0)
                    DXButton(text: store.l10n.scanButtonTitle) {
                        store.send(.scanButtonTapped)
                    }
                }
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 20)
            .navigationTitle(store.l10n.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
