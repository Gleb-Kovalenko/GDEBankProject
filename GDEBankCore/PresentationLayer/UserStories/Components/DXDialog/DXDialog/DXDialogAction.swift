//
//  DXDialogAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - DXDialogAction

@CasePathable
public enum DXDialogAction: Equatable {
    
    // MARK: - Cases
    
    /// An action that calls when error occured
    case errorOccured(NSError)
    
    /// An action that calls when file link obtained
    case fileLinkObtained(URL)
    
    /// An action that calls when file dowloaded
    case fileDownloaded(URL)
    
    /// Share sheet dismiss
    case shareSheetDismiss
    
    // MARK: - Variations

    /// An action that calls when user taps on the `Confirm` button
    case confirmButtonTapped
    
    /// An action that calls when user taps on the `Continue` button
    case continueButtonTapped

    /// An action that calls when user taps on the `Decline` button
    case declineButtonTapped

    /// An action that calls when user taps on the `Delete` button
    case deleteButtonTapped

    /// An action that calls when user taps on the `Cancel` button
    case cancelButtonTapped

    /// An action that calls when user taps on the `Block` button
    case blockButtonTapped

    /// An action that calls when user taps on the `To Main` button
    case toMainButtonTapped

    /// An action that calls when user taps on the `Get Receipt` button
    case getReceiptButtonTapped

    /// An action that calls when user taps on the `Back` button
    case backButtonTapped

    /// An action that calls when user taps on the `Access` button
    case accessButtonTapped

    /// An action that calls when user taps on the `Exit` button
    case exitButtonTapped
    
    /// An action that calls when user taps on the `Close` button
    case closeButtonTapped
    
    // MARK: - Children
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case alert(PresentationAction<DXAlertAction>)
    
    /// Child action for `FilePreview` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `filePreview` case means that every action in `FilePreview` module
    /// will be sent to current module through it
    case filePreview(PresentationAction<FilePreviewAction>)
}
