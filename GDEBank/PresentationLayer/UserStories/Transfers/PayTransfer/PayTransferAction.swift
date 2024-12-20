//
//  PayTransferAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore
import Foundation

// MARK: - PayTransferAction

@CasePathable
public enum PayTransferAction: Equatable {
    
    // MARK: - Cases
    
    /// An action that calls when user taps on the `Transfer` button
    case transferButtonTapped
    
    /// An action that calls when transfer completed successfully
    case transferCompletedSuccesfully
    
    // MARK: - Binding
    
    /// An action that calls when need to set amount text
    case setAmountText(String)
    
    /// An action that calls when need to set currency
    case setCurrency(CurrencyType)
    
    // MARK: - Children
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case alert(PresentationAction<DXAlertAction>)
    
    // MARK: - Service
    
    /// An action that calls when transfer completed
    case transferCompleted(Result<Bool, NSError>)
}
