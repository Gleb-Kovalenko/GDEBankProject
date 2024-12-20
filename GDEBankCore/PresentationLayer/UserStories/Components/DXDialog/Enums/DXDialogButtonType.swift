//
//  DXDialogButtonType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 01.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - DXDialogButtonType

public enum DXDialogButtonType: Identifiable {
    
    // MARK: - Cases
    
    /// Primary button (always show upper than secondary)
    case primary(title: String, style: DXButton.Style, leadingImage: Image? = nil, action: DXDialogAction)
    
    /// Secondary button (always show lower than primary)
    case secondary(title: String, style: DXButton.Style, leadingImage: Image? = nil, action: DXDialogAction)
    
    // MARK: - Useful
    
    public var id: String {
        switch self {
        case .primary:
            return "primary"
        case .secondary:
            return "secondary"
        }
    }
    
    // MARK: - Unwrapping
    
    public var title: String {
        switch self {
        case .primary(let title, _, _, _),
             .secondary(let title, _, _, _):
            return title
        }
    }
    
    public var style: DXButton.Style {
        switch self {
        case .primary(_, let style, _, _),
             .secondary(_, let style, _, _):
            return style
        }
    }
    
    public var leadingImage: Image? {
        switch self {
        case .primary(_, _, let leadingImage, _),
             .secondary(_, _, let leadingImage, _):
            return leadingImage
        }
    }
    
    public var action: DXDialogAction {
        switch self {
        case .primary(_, _, _, let action),
             .secondary(_, _, _, let action):
            return action
        }
    }
}

// MARK: - DXDialogButtonType

extension DXDialogButtonType: Equatable {
    
    public static func == (lhs: DXDialogButtonType, rhs: DXDialogButtonType) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
    }
}

// MARK: - Variations

extension DXDialogButtonType {

    public static var confirm: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.confirm,
            style: .fill,
            action: .confirmButtonTapped
        )
    }

    public static var decline: DXDialogButtonType {
        .secondary(
            title: L10n.DxDialog.ButtonTitle.decline,
            style: .control(
                fill: false
            ),
            action: .declineButtonTapped
        )
    }

    public static var delete: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.delete,
            style: .destructive,
            action: .deleteButtonTapped
        )
    }
    
    public static var deletePlain: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.delete,
            style: .text,
            action: .deleteButtonTapped
        )
    }

    public static var cancel: DXDialogButtonType {
        .secondary(
            title: L10n.DxDialog.ButtonTitle.cancel,
            style: .control(
                fill: false
            ),
            action: .cancelButtonTapped
        )
    }
    
    public static var cancelPlain: DXDialogButtonType {
        .secondary(
            title: L10n.DxDialog.ButtonTitle.cancel,
            style: .text,
            action: .cancelButtonTapped
        )
    }

    public static var block: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.block,
            style: .destructive,
            action: .blockButtonTapped
        )
    }

    public static var toMain: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.toMain,
            style: .fill,
            action: .toMainButtonTapped
        )
    }
    
    public static var toMainPlain: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.toMain,
            style: .outline,
            action: .toMainButtonTapped
        )
    }

    public static var getReceipt: DXDialogButtonType {
        .secondary(
            title: L10n.DxDialog.ButtonTitle.getReceipt,
            style: .control(
                fill: false
            ),
            leadingImage: CoreAssets.receipt.swiftUIImage,
            action: .getReceiptButtonTapped
        )
    }

    public static var back: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.back,
            style: .control(
                fill: false
            ),
            action: .backButtonTapped
        )
    }
    
    public static var `continue`: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.continue,
            style: .control(
                fill: false
            ),
            action: .continueButtonTapped
        )
    }

    public static var access: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.allow,
            style: .control(
                fill: false
            ),
            action: .accessButtonTapped
        )
    }
    
    public static var exit: DXDialogButtonType {
        .primary(
            title: L10n.DxDialog.ButtonTitle.exit,
            style: .control(
                fill: false
            ),
            action: .exitButtonTapped
        )
    }
}

// MARK: - Array+Variations

extension Array where Element == DXDialogButtonType {
    
    public static var codeChanged: [DXDialogButtonType] {
        [.toMainPlain]
    }
    
    public static var emptyMemo: [DXDialogButtonType] {
        [.continue]
    }
    
    public static var codeSaved: [DXDialogButtonType] {
        [.toMainPlain]
    }
    
    public static var phoneNumberChanged: [DXDialogButtonType] {
        [.toMain]
    }
    
    public static var emailChanged: [DXDialogButtonType] {
        [.toMain]
    }
    
    public static var deleteCards: [DXDialogButtonType] {
        [.delete, .cancel]
    }
    
    public static var cardDeleted: [DXDialogButtonType] {
        [.toMainPlain]
    }
    
    public static var pinChanged: [DXDialogButtonType] {
        [.toMainPlain]
    }
    
    public static var photoAccess: [DXDialogButtonType] {
        [.access]
    }
    
    public static var insufficientFunds: [DXDialogButtonType] {
        [.back]
    }
    
    public static var successfulExchange: [DXDialogButtonType] {
        [.toMainPlain]
    }

    public static var successfulRecharge: [DXDialogButtonType] {
        [.getReceipt, .toMain]
    }
    
    public static var successfulTransfer: [DXDialogButtonType] {
        [.getReceipt, .toMain]
    }
    
    public static var successfulTransferWithoutCheck: [DXDialogButtonType] {
        [.toMain]
    }
    
    public static var logoutConfirmation: [DXDialogButtonType] {
        [.exit, .cancelPlain]
    }
    
    public static var accessDenied: [DXDialogButtonType] {
        [.back]
    }
    
    public static var confirmLoginButtons: [DXDialogButtonType] {
        [.confirm, .decline]
    }
    
    public static var passwordChanged: [DXDialogButtonType] {
        []
    }
    
    public static var deleteAccountConfirmation: [DXDialogButtonType] {
        [.cancel, .deletePlain]
    }
    
    public static var blockCard: [DXDialogButtonType] {
        [.block, .cancel]
    }
}
