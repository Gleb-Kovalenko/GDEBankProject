//
//  PayQRReceivingView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit
import GDEBankCore
import Kingfisher

// MARK: - PayQRReceivingView

@WithLocalizationUpdater
public struct PayQRReceivingView: View {
    
    // MARK: - Properties

    /// The store powering the `PayQRReceiving` reducer
    @Perception.Bindable public var store: StoreOf<PayQRReceiving>
    
    /// Appearance settings for `PayQRReceivingView`.
    public let appearance: PayQRReceivingViewAppearance
    
    /// The currently focused text field
    @FocusState private var focusedField: PayQRReceivingState.Focus?

    // MARK: - Initializers
    
    /// Initializes the `PayQRReceivingView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `PayQRReceiving` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<PayQRReceiving>,
        appearance: PayQRReceivingViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    /// Initializes the `PayQRReceivingView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `PayQRReceiving` reducer.
    public init(store: StoreOf<PayQRReceiving>) {
        self.store = store
        self.appearance = .default
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Picker(
                        "",
                        selection: $store.selectedTab.sending(\.tabTapped),
                        content: {
                            ForEach(PayQRReceivingState.QRType.allCases, id: \.self) { qrType in
                                Text(qrType.title)
                                    .tag(qrType)
                            }
                        }
                    )
                    .pickerStyle(.segmented)
                    switch store.selectedTab {
                    case .static:
                        staticQrCodeView
                            .tag(PayQRReceivingState.QRType.static)
                    case .dynamic:
                        dynamicQrCodeView
                            .tag(PayQRReceivingState.QRType.dynamic)
                    }
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .alert(store: store.scope(state: \.$alert, action: \.alert))
            .shareSheet(store.scope(state: \.shareSheet), dismiss: .shareSheetDismiss)
            .navigationTitle(store.l10n.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    keyboardToolBarItem
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
    
    // MARK: - Subviews
    
    private func qrImageView(url: URL?, size: CGFloat) -> some View {
        KFImage(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .placeholder {
                LoaderView(appearance: .small)
            }
            .resizable()
            .scaledToFit()
            .frame(size: size)
    }
    
    private var staticQrCodeView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                qrImageView(
                    url: store.staticQrURL,
                    size: 140
                )
                .padding(20)
                Text(store.l10n.staticQrCodeDescription)
                    .font(appearance.descriptionFont)
                    .foregroundStyle(appearance.descriptionColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            VStack(spacing: 16) {
                DXButton(
                    text: store.l10n.shareButtonTitle,
                    leadingImage: CoreAssets.upload.swiftUIImage,
                    style: .outline
                ) {
                    store.send(.shareButtonTapped(type: .static))
                }
            }
        }
    }
    
    private var dynamicQrCodeView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(store.l10n.transferDataTitle)
                .font(appearance.sectionTitleFont)
                .padding(.vertical, 8)
            VStack(spacing: 12) {
                RowFieldView(
                    title: store.l10n.currencyLabel,
                    content: currencyMenu,
                    appearance: appearance
                )
                RowFieldView(
                    title: store.l10n.amountPlaceholder,
                    content: amountTextFieldView,
                    appearance: appearance
                )
            }
            if store.dynamicQrURL == nil {
                DXButton(
                    text: store.l10n.generateQrCodeButtonTitle
                ) {
                    focusedField = nil
                    store.send(.generateQrButtonTapped)
                }
                .disabled(!store.isGenerateQRAvailable)
            } else {
                dynamicGeneratedQrCodeView
            }
        }
    }
    
    private var currencyMenu: some View {
        Menu {
            ForEach(store.possibleCurrencies, id: \.currencyType) { currency in
                Button {
                    focusedField = .amount
                    store.send(.currencySelected(currency))
                } label: {
                    HStack(spacing: 4) {
                        Image(currency.currencyType.cirleImageName)
                            .scaledImage(with: .fit, height: 16)
                        Text(currency.currencyType.shortName)
                    }
                    .font(appearance.currencyMenuItemFont)
                }
            }
        } label: {
            HStack(spacing: 12) {
                Image(store.selectedCurrency.currencyType.cirleImageName)
                    .scaledImage(with: .fit, size: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text(store.l10n.currencyText(currency: store.selectedCurrency))
                        .font(appearance.balanceTitleFont)
                        .foregroundStyle(CoreColors.textDefault.swiftUIColor)
                    Text(
                        store.l10n.currencyBalanceText(
                            currencyType: store.selectedCurrency.currencyType
                        )
                    )
                    .font(appearance.balanceSubtitleFont)
                    .foregroundStyle(appearance.balanceSubtitleColor)
                }
                Spacer(minLength: 0)
                CoreAssets.chevronDown.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .dxBorder()
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    
    private var amountTextFieldView: some View {
        DXTextField(
            text: $store.dynamicQrSumText.sending(\.setSumText),
            focus: $focusedField,
            targetFocus: .amount,
            maxLength: AppConstants.Business.TextFields.maxAmountLength,
            keyboardType: .decimalPad,
            appearance: .noBorderAndSpacings
        )
        .padding(12)
        .dxBorder()
    }
    
    private var dynamicGeneratedQrCodeView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                qrImageView(
                    url: store.dynamicQrURL,
                    size: 200
                )
                .padding(20)
                dynamicQrWarningView
                    .padding(.horizontal, 50)
            }
            .padding(.vertical, 12)
            DXButton(
                text: store.l10n.shareButtonTitle,
                trailingImage: CoreAssets.arrowBendUpRight.swiftUIImage,
                style: .outline
            ) {
                store.send(.shareButtonTapped(type: .dynamic))
            }
        }
    }
    
    private var dynamicQrWarningView: some View {
        HStack(spacing: 4) {
            CoreAssets.alertCircle.swiftUIImage
                .dxImage(
                    size: 18,
                    color: appearance.warningColor
                )
                .frame(size: 24)
            Text(store.l10n.dynamicQrWarning)
                .font(appearance.warningFont)
                .foregroundStyle(appearance.warningColor)
        }
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
    let appearance: PayQRReceivingViewAppearance
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(appearance.fieldLabelFont)
                .foregroundStyle(appearance.fieldLabelColor)
                .padding(.leading, 4)
            content
        }
    }
}
