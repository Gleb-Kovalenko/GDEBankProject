//
//  DXReloadable+Init.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 29.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import TCANetworkReducers

// MARK: - DXReloadableState

extension DXReloadableState {
    
    // MARK: - Initializers
    
    public static func initial(
        status: DXReloadableState<Data, ErrorType>.Status = .initial,
        data: Data? = nil,
        autoReloading: DXReloadableState<Data, ErrorType>.AutoReloadingType = .none,
        reloadingAttemptsCount: Int = 0,
        alertMode: DXReloadableState<Data, ErrorType>.AlertMode = .onFailure(shoudDisplayOnReload: true),
        shouldDisplayLoader: Bool = true
    ) -> DXReloadableState {
        return .init(
            status: status,
            data: data,
            autoReloadingMode: autoReloading,
            reloadingAttemptsCount: reloadingAttemptsCount,
            alertMode: alertMode,
            shouldDisplayLoader: shouldDisplayLoader
        )
    }
}

// MARK: - DXIDReloadableState

extension DXIDReloadableState {
    
    public static func initial(
        id: ID,
        status: DXReloadableState<Data, ErrorType>.Status = .initial,
        data: Data? = nil,
        autoReloading: DXReloadableState<Data, ErrorType>.AutoReloadingType = .none,
        reloadingAttemptsCount: Int = 0,
        alertMode: DXReloadableState<Data, ErrorType>.AlertMode = .onFailure(shoudDisplayOnReload: true),
        shouldDisplayLoader: Bool = true
    ) -> DXIDReloadableState {
        return .init(
            id: id,
            status: status,
            data: data,
            autoReloadingMode: autoReloading,
            reloadingAttemptsCount: reloadingAttemptsCount,
            alertMode: alertMode,
            shouldDisplayLoader: shouldDisplayLoader
        )
    }
}
