//
//  MainTabCoordinatorLocalization.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 25.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import GDEBankCore
import SwiftMacrosKit

// MARK: - MainTabCoordinatorLocalization

@DynamicStringWrapper
public struct MainTabCoordinatorLocalization {
}

// MARK: - Variations

extension MainTabCoordinatorLocalization {
    
    public static var `default`: MainTabCoordinatorLocalization {
        MainTabCoordinatorLocalization(
        )
    }
}
