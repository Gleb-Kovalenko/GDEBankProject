//
//  MainTabCoordinatorState.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 24.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore

// MARK: - MainTabCoordinatorState

@ObservableState
public struct MainTabCoordinatorState: Equatable {
    
    // MARK: - Properties
    
    /// Indicates is remoting operation now
    public var isRemotingOperation = false
    
    /// Module localization
    public var l10n: MainTabCoordinatorLocalization = .default
    
    // MARK: - Children
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var alert: AlertState<DXAlertAction>?
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var qrAlert: AlertState<DXAlertAction>?
    
    /// `MainState` instance
    ///
    /// It's an instance of `Main` submodule.
    /// We use it here to be able to integrate `Main` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Main` module all changes will be saved here.
    public var main = MainState()
    
    /// Modal module destination
    @Presents var modalDestination: MainTabCoordinator.Path.State?
    
    /// Application stack state
    public var path = StackState<MainTabCoordinator.Path.State>()
}

// MARK: - Variations

extension MainTabCoordinatorState {
    
    public static var initial: MainTabCoordinatorState {
        MainTabCoordinatorState()
    }
}
