//
//  GDEBankApplication.swift
//  GDEBank
//
//  Created by incetro on 8/13/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import GDEBankCore
import ComposableArchitecture
import Swinject
import Foundation
import UIKit

// MARK: - GDEBankApplication

@Reducer
public struct GDEBankApplication {
    
    // MARK: - Properties
    
    /// `SessionStorage` instance
    private let sessionStorage: SessionStorage
    
    /// `UserDefaults` instance
    private let userDefaults: UserDefaults
    /// NotificationCenter instance
    public let notificationCenter: NotificationCenter
    
    /// Scheduler instance
    private let scheduler: AnySchedulerOf<DispatchQueue>
    
    /// `Keychain` service
    private let keychainService: KeychainService
    
    /// Assembly container
    private static var container: Container {
        AssembliesHolder.container
    }
    
    // MARK: - Initializers
    
    public init(
        userDefaults: UserDefaults,
        sessionStorage: SessionStorage,
        notificationCenter: NotificationCenter,
        scheduler: AnySchedulerOf<DispatchQueue> = .main,
        keychainService: KeychainService
    ) {
        self.userDefaults = userDefaults
        self.sessionStorage = sessionStorage
        self.notificationCenter = notificationCenter
        self.scheduler = scheduler
        self.keychainService = keychainService
    }
    
    // MARK: - Path
    
    @Reducer(state: .equatable)
    public enum Path {
        
        // MARK: - Cases
        
        case payLogin(PayLogin)
        
        // MARK: - DXDialog
        
        case dxDialog(DXDialog)
        
        // MARK: - ReducerBuilder
        
        public static var body: some ReducerOf<Self> {
            Scope(state: \.payLogin, action: \.payLogin) {
                PayLogin()
            }
        }
    }
    
    // MARK: - Aliases
    
    public typealias State  = GDEBankApplicationState
    public typealias Action = GDEBankApplicationAction
    
    // MARK: - Feature
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.payLogin, action: \.payLogin) {
            PayLogin()
        }
        Scope(state: \.payTab, action: \.payTab) {
            PayTab(
                defaults: GDEBankApplication.container.resolve(),
                notificationCenter: GDEBankApplication.container.resolve()
            )
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                return notificationCenter
                    .publisher(for: .logout)
                    .receive(on: DispatchQueue.main.eraseToAnyScheduler())
                    .map { _ in GDEBankApplication.Action.makeLogout }
                    .eraseToEffect()
            case .payLogin(.connectButtonTapped), .path(.element(_, .payLogin(.connectButtonTapped))):
                return .send(.sessionActivated(.success(true)))
            case .payTab(.logoutButtonTapped):
                state.modalDestination = .dxDialog(.logoutConfirmation)
            case .modalDestination(.presented(.dxDialog(.exitButtonTapped))):
                state.modalDestination = nil
                NotificationCenter.default.post(name: .logout, object: nil)
            case .modalDestination(.presented(.dxDialog(.cancelButtonTapped))):
                state.modalDestination = nil
            case .makeLogout:
                state.isUserAuthorized = false
                sessionStorage.clear()
                state.payTab = .initial
                state.path.removeAll()
            default:
                break
            }
            return processURLSchemesFlows(state: &state, action: action) ?? .none
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$modalDestination, action: \.modalDestination) {
            GDEBankApplication.Path.body
        }
    }
    
    private func processURLSchemesFlows(
        state: inout GDEBankApplicationState,
        action: GDEBankApplicationAction
    ) -> Effect<GDEBankApplicationAction>? {
        switch action {
        case .modalDestination(.presented(.dxDialog(.backButtonTapped))):
            state.modalDestination = nil
        case .sessionActivated(.success(true)):
            state.isRemoteOperation = false
            state.isUserAuthorized = true
        case .sessionActivated(.success(false)):
            state.isRemoteOperation = false
        case .sessionActivated(.failure(let error)):
            state.isRemoteOperation = false
            state.alert = .show(error: error)
        default:
            return nil
        }
        return nil
    }
}
