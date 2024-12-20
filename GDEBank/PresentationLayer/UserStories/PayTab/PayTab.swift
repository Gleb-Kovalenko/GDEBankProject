//
//  PayTab.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import Combine
import Foundation
import HTTPTransport
import ComposableArchitecture
import GDEBankCore

// MARK: - PayTab

@Reducer
public struct PayTab {
    
    // MARK: - Aliases
    
    public typealias State = PayTabState
    public typealias Action = PayTabAction
    
    // MARK: - CancelID
    
    private enum CancelID: Hashable {
        case logout
    }
    
    // MARK: - Properties

    /// UserDefaults instance
    public let defaults: UserDefaults
    
    /// NotificationCenter instance
    public let notificationCenter: NotificationCenter
    
    // MARK: - Reducer

    public var body: some Reducer<PayTabState, PayTabAction> {
        Scope(state: \.mainTabCoordinator, action: \.mainTabCoordinator) {
            MainTabCoordinator()
        }
        Reduce { state, action in
            switch action {
            case .tabButtonTapped(let tab):
                if tab == .exit {
                    return .send(.logoutButtonTapped)
                }
                state.selectedTab = tab
            default:
                break
            }
            return .none
        }
    }
}
