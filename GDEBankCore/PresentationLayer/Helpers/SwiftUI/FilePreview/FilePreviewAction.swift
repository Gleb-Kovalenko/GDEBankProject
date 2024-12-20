//
//  FilePreviewAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - FilePreviewAction

@CasePathable
public enum FilePreviewAction: Equatable {
    
    // MARK: - Cases
    
    /// General action that calls when view appears
    case onAppear
    
    /// General action that calls when view disappears
    case onDisappear
    
    /// An action that calls when user taps on the `ShareSheet` button
    case shareSheetButtonTapped
    
    /// An action that calls when error occured
    case errorOccured(NSError)
    
    /// An action that calls when file dowloaded
    case fileDownloaded(URL)
    
    /// Share sheet dismiss
    case shareSheetDismiss
    
    // MARK: - Children
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case alert(PresentationAction<DXAlertAction>)
}
