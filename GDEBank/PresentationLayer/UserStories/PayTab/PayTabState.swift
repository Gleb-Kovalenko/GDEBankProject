//
//  PayTabState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import GDEBankCore
import Foundation
import ComposableArchitecture

// MARK: - PayTabState

@ObservableState
public struct PayTabState: Equatable {
    
    // MARK: - Properties
    
    /// Selected tab
    public var selectedTab: Tabs = .main
    
    // MARK: - Children
    
    /// `MainTabCoordinatorState` instance
    ///
    /// It's an instance of `MainTabCoordinator` submodule.
    /// We use it here to be able to integrate `MainTabCoordinator` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `MainTabCoordinator` module all changes will be saved here.
    public var mainTabCoordinator: MainTabCoordinatorState = .initial
}

// MARK: - Variations

extension PayTabState {
    
    public static var initial: PayTabState {
        PayTabState()
    }
}
