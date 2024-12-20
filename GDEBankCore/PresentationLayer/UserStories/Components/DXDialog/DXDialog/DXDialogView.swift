//
//  DXDialogView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - DXDialogView

@WithLocalizationUpdater
public struct DXDialogView: View {
    
    // MARK: - Properties

    /// The store powering the `DXDialog` reducer
    @Perception.Bindable public var store: StoreOf<DXDialog>
    
    /// View appearance
    public let appearance: DXDialogViewAppearance
    
    // MARK: - Initializers
    
    /// Initializes a `DXDialogView` with the specified store and appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store managing the state of `DXDialog`.
    ///   - appearance: The appearance settings for customizing the view's fonts and colors.
    public init(
        store: StoreOf<DXDialog>,
        appearance: DXDialogViewAppearance
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: appearance.spacing) {
                dialogImageView
                titleView
                if !store.buttons.isEmpty {
                    buttonsStackView
                }
                if appearance.pinToTop {
                    Spacer(minLength: 0)
                }
            }
            .padding(.vertical, appearance.verticalPaddings)
            .padding(.horizontal, appearance.horizontalPaddings)
            .background(appearance.backgroundColor)
            .smoothCorners(radius: appearance.cornerRadius ?? 0)
            .navigationTitle(store.navigationTitle ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .loadingState(isActive: store.isRemotingOperation)
            .alert(store: store.scope(state: \.$alert, action: \.alert))
            .shareSheet(store.scope(state: \.shareSheet), dismiss: .shareSheetDismiss)
            .filePreview(store: $store.scope(state: \.filePreview, action: \.filePreview))
        }
    }
    
    // MARK: - Subviews
    
    private var dialogImageView: some View {
        ZStack {
            Circle()
                .fill(store.dialogImageType.outerCircleColor)
                .frame(size: appearance.outerCircleSize)
            Image(store.dialogImageType.imageName)
                .dxImage(
                    size: appearance.imageSize,
                    color: store.dialogImageType.imageColor
                )
        }
        .frame(size: appearance.outerCircleSize)
    }
    
    private var titleView: some View {
        Text(store.title)
            .font(appearance.titleFont)
            .foregroundStyle(appearance.titleColor)
            .multilineTextAlignment(.center)
    }
    
    private var buttonsStackView: some View {
        VStack(spacing: appearance.buttonsSpacing) {
            ForEach(store.buttons) { buttonType in
                DXButton(type: buttonType) {
                    store.send(buttonType.action)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DXDialogView(
        store: Store(
            initialState: DXDialogState.blockCardConfirmation,
            reducer: { DXDialog() }
        ),
        appearance: .popup
    )
}
