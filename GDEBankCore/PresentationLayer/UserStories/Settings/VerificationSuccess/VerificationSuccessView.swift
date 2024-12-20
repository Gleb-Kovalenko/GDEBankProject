//
//  VerificationSuccessView.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 23.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - VerificationSuccessView

@WithLocalizationUpdater
public struct VerificationSuccessView: View {

    // MARK: - Properties

    /// The store powering the `VerificationSuccess` reducer
    public let store: StoreOf<VerificationSuccess>
    
    /// The appearance settings for the view
    public let appearance: VerificationSuccessViewAppearance

    // MARK: - Initializers

    /// Initializes a new `VerificationSuccessView` with the specified store and appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `VerificationSuccess` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<VerificationSuccess>, 
        appearance: VerificationSuccessViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }

    // MARK: - View

    public var body: some View {
        VStack(spacing: 0) {
            iconCircleView
                .padding(.bottom, 32)
            titleView
                .padding(.bottom, 32)
            buttonView
                .padding(.horizontal, 20)
        }
        .padding(.top, 24)
        Spacer(minLength: 0)
    }
    
    private var iconCircleView: some View {
        IconCircleView(
            image: Assets.checkCircle.image,
            backgroundColor: appearance.successCircleBackgroundColor,
            iconColor: appearance.successCircleIconColor,
            iconSize: CGSize(width: appearance.imageFrame, height: appearance.imageFrame)
        )
    }
    
    private var titleView: some View {
        Text(store.l10n.title)
            .font(appearance.titleFont)
            .foregroundColor(appearance.titleColor)
            .multilineTextAlignment(.center)
    }
    
    private var buttonView: some View {
        DXButton(text: store.l10n.buttonTitle) {
            store.send(.buttonTapped)
        }
        .frame(height: appearance.buttonHeight)
    }
}
