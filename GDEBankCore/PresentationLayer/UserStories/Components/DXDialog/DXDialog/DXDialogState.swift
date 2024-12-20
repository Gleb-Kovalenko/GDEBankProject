//
//  DXDialogState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - DXDialogState

@ObservableState
@AutoInit
public struct DXDialogState: Equatable {
    
    // MARK: - Properties
    
    /// Dialog title
    public let title: String
    
    /// Dialog image name
    public let dialogImageType: DXDialogImageType
    
    /// File url
    public let fileURL: URL?
    
    /// Indicates is need to show close button
    public let showCloseButton: Bool
    
    /// Navigation title
    public let navigationTitle: String?
    
    /// Indicates is remoting operation now
    public var isRemotingOperation = false
    
    /// Buttons
    public let buttons: [DXDialogButtonType]
    
    // MARK: - Children
    
    /// Share sheet state instance
    @Presents public var shareSheet: ShareSheetState<DXDialogAction>?
    
    /// `FilePreviewState` instance
    ///
    /// It's an instance of `FilePreview` submodule.
    /// We use it here to be able to integrate `FilePreview` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `FilePreview` module all changes will be saved here.
    @Presents public var filePreview: FilePreviewState?
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var alert: AlertState<DXAlertAction>?
}

// MARK: - Variations

extension DXDialogState {
    
    public static var codeChanged: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.codeChanged,
            dialogImageType: .success,
            showCloseButton: true,
            buttons: .codeChanged
        )
    }
    
    public static var codeSaved: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.codeSaved,
            dialogImageType: .success,
            showCloseButton: true,
            buttons: .codeSaved
        )
    }
    
    public static var phoneNumberChanged: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.phoneNumberChanged,
            dialogImageType: .success,
            showCloseButton: true,
            navigationTitle: L10n.CodeConfirmation.ChangePhone.navigationTitle,
            buttons: .phoneNumberChanged
        )
    }
    
    public static var emailChanged: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.emailChanged,
            dialogImageType: .success,
            showCloseButton: true,
            navigationTitle: L10n.CodeConfirmation.ChangeEmail.navigationTitle,
            buttons: .emailChanged
        )
    }
    
    public static var deleteCardConfirmation: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.deleteCardConfirmation,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .deleteCards
        )
    }
    
    public static var emptyMemo: DXDialogState {
        DXDialogState(
            title: L10n.General.requiredMemoMessage,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .emptyMemo
        )
    }
    
    public static var cardDeleted: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.cardDeleted,
            dialogImageType: .success,
            showCloseButton: true,
            buttons: .cardDeleted
        )
    }
    
    public static var pinChanged: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.pinChanged,
            dialogImageType: .success,
            showCloseButton: true,
            buttons: .pinChanged
        )
    }
    
    public static var photoAccess: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.photoAccess,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .photoAccess
        )
    }
    
    public static var insufficientFunds: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.insufficientFunds,
            dialogImageType: .error,
            showCloseButton: true,
            buttons: .insufficientFunds
        )
    }
    
    public static var successfulExchange: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.successfulExchange,
            dialogImageType: .success,
            showCloseButton: true,
            buttons: .successfulExchange
        )
    }
    
    public static var successfulRecharge: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.successfulRecharge,
            dialogImageType: .success,
            showCloseButton: false,
            buttons: .successfulRecharge
        )
    }
    
    public static func successfulTransfer(fileURL: URL?) -> DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.successfulTransfer,
            dialogImageType: .success,
            fileURL: fileURL,
            showCloseButton: false,
            buttons: fileURL == nil ? .successfulTransferWithoutCheck : .successfulTransfer
        )
    }
    
    public static var successfulTransferWithoutCheck: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.successfulTransfer,
            dialogImageType: .success,
            showCloseButton: false,
            buttons: .successfulTransferWithoutCheck
        )
    }
    
    public static var logoutConfirmation: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.logoutConfirmation,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .logoutConfirmation
        )
    }
    
    public static var accessDenied: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.accessDenied,
            dialogImageType: .error,
            showCloseButton: true,
            buttons: .accessDenied
        )
    }
    
    public static var loginConfirmation: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.loginConfirmation,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .confirmLoginButtons
        )
    }
    
    public static var passwordChanged: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.passwordChanged,
            dialogImageType: .success,
            showCloseButton: true,
            buttons: .passwordChanged
        )
    }
    
    public static var deleteAccountConfirmation: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.deleteAccountConfirmation,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .deleteCards
        )
    }

    public static var blockCardConfirmation: DXDialogState {
        DXDialogState(
            title: L10n.DxDialog.Title.blockCardConfirmation,
            dialogImageType: .warning,
            showCloseButton: true,
            buttons: .blockCard
        )
    }
}
