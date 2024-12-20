//
//  GDEBankApplicationState.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 11.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore

// MARK: - GDEBankApplicationState

@ObservableState
public struct GDEBankApplicationState: Equatable {
    
    // MARK: - Properties
    
    @Shared(.useDarkTheme)
    public var useDarkTheme = false
    
    /// Indicates is user authorized
    public var isUserAuthorized: Bool
    
    /// Indicates is remote operation
    public var isRemoteOperation = false

    // MARK: - Children
    
    /// `PayLoginState` instance
    ///
    /// It's an instance of `PayLogin` submodule.
    /// We use it here to be able to integrate `PayLogin` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `PayLogin` module all changes will be saved here.
    public var payLogin = PayLoginState()
    
    /// `PayTabState` instance
    ///
    /// It's an instance of `PayTab` submodule.
    /// We use it here to be able to integrate `PayTab` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `PayTab` module all changes will be saved here.
    public var payTab: PayTabState = .initial
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var alert: AlertState<DXAlertAction>?
    
    /// Modal destination state
    @Presents public var modalDestination: GDEBankApplication.Path.State?
    
    /// Application stack state
    public var path = StackState<GDEBankApplication.Path.State>()
}
