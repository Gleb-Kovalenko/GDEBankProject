//
//  PayTransferView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import GDEBankCore
import SwiftMacrosKit

// MARK: - PayTransferView

@WithLocalizationUpdater
public struct PayTransferView: View {
    
    // MARK: - Properties

    /// The store powering the `PayTransfer` reducer
    @Perception.Bindable public var store: StoreOf<PayTransfer>
    
    /// Appearance settings for `PayTransferView`.
    public let appearance: PayTransferViewAppearance
    
    /// The currently focused text field
    @FocusState private var focusedField: PayTransferState.Focus?

    // MARK: - Initializers
    
    /// Initializes the `PayTransferView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `PayTransfer` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<PayTransfer>,
        appearance: PayTransferViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    /// Initializes the `PayTransferView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `PayTransfer` reducer.
    public init(store: StoreOf<PayTransfer>) {
        self.store = store
        self.appearance = .default
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 24) {
                        RowFieldView(
                            title: store.l10n.recipientLabel,
                            content: emailView,
                            appearance: appearance
                        )
                        VStack(spacing: 12) {
                            RowFieldView(
                                title: store.l10n.amountLabel,
                                content: amountTextFieldView,
                                appearance: appearance
                            )
                            RowFieldView(
                                title: store.l10n.currencyLabel,
                                content: currencyMenu,
                                appearance: appearance
                            )
                        }
                    }
                    DXButton(text: store.l10n.transferButtonTitle) {
                        focusedField = nil
                        store.send(.transferButtonTapped)
                    }
                    .disabled(store.isRemotingOperation)
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    keyboardToolBarItem
                }
            }
            .onAppear {
                if store.isEditingAvailable {
                    focusedField = .amount
                }
            }
            .navigationTitle(store.l10n.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .loadingState(isActive: store.isRemotingOperation)
            .alert(store: store.scope(state: \.$alert, action: \.alert))
        }
 
    }
    
    // MARK: - Subviews
    
    private var emailView: some View {
        HStack(spacing: 12) {
            CircledImage(
                imageName: CoreAssets.user.name,
                imageSize: 20,
                circleSize: 40,
                circleColor: CoreColors.gray6.swiftUIColor,
                imageColor: CoreColors.gray1.swiftUIColor
            )
            Text(store.email)
                .font(appearance.emailTextFont)
        }
    }
    
    private var amountTextFieldView: some View {
        DXTextField(
            text: $store.amountText.sending(\.setAmountText),
            focus: $focusedField,
            targetFocus: .amount,
            maxLength: AppConstants.Business.TextFields.maxAmountLength,
            keyboardType: .decimalPad,
            validation: { _ in
                if store.isInsufficientFundsError {
                    return (isValid: false, message: store.l10n.insufficientFundsError)
                } else {
                    return (isValid: true, message: nil)
                }
            },
            appearance: .amountTextField
        )
        .disabled(!store.isEditingAvailable)
    }
    
    private var currencyMenu: some View {
        Menu {
            ForEach(CurrencyType.allCases, id: \.self) { currency in
                Button {
                    focusedField = .amount
                    store.send(.setCurrency(currency))
                } label: {
                    HStack(spacing: 4) {
                        Image(currency.cirleImageName)
                            .scaledImage(with: .fit, height: 16)
                        Text(currency.shortName)
                    }
                    .font(appearance.currencyMenuItemFont)
                }
            }
        } label: {
            HStack(spacing: 8) {
                Image(store.currency.cirleImageName)
                    .scaledImage(with: .fit, size: 24)
                Text(store.currency.shortName.uppercased())
                    .font(appearance.currencyFont)
                    .foregroundStyle(CoreColors.textDefault.swiftUIColor)
                Spacer(minLength: 0)
                if store.isEditingAvailable {
                    CoreAssets.chevronDown.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .dxBorder()
        }
        .onTapGesture {
            focusedField = nil
        }
        .disabled(!store.isEditingAvailable)
    }
    
    /// Toolbar item with buttons for navigating between input fields and dismissing the keyboard.
    public var keyboardToolBarItem: some View {
        HStack {
            Spacer()
            Button(store.l10n.keyboardDoneButtonText) {
                focusedField = nil
            }
        }
        .tint(CoreColors.textDefault.swiftUIColor)
    }
}
// MARK: - RowFieldView

private struct RowFieldView<Content: View>: View {
    
    // MARK: - Properties
    
    /// Field title
    let title: String
    
    /// Field content
    let content: Content
    
    /// Appearance
    let appearance: PayTransferViewAppearance
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(appearance.fieldTitleFont)
                .foregroundStyle(appearance.fieldTitleColor)
            content
        }
    }
}
