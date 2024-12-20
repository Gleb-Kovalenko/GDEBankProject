//
//  GDEBankApp.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 13.08.2024.
//

import SwiftUI
import Swinject
import GDEBankCore
import ComposableArchitecture
import Combine

// MARK: - GDEBankApp

@main
struct GDEBankApp: App {

    // MARK: - Properties

    /// DI Container instance
    private let container: Container

    /// `UserDefaults` instance
    private let defaults: UserDefaults
    
    /// `SessionStorage` instance
    private let sessionStorage: SessionStorage
    
    /// `Localizer` instance
    private let localizer: Localizer

    /// `NotificationCenter` instance
    private let notificationCenter: NotificationCenter
    
    /// `Keychain` service instance
    private let keychainService: KeychainService

    // MARK: - Initializers

    init() {

        container = AssembliesHolder.container

        GDEBankCoreAssembliesCollector.collect()
        GDEBankAssembliesCollector.collect()

        defaults = container.resolve()
        notificationCenter = container.resolve()
        sessionStorage = container.resolve()
        localizer = container.resolve()
        keychainService = container.resolve()
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UIBarButtonItem.appearance().tintColor = CoreColors.textDefault.color
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.clear

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance

        let daemons: [Daemon] = container.resolve()
        daemons.forEach { daemon in
            daemon.start()
        }
        
        let language = AppStorageKey<AppLanguage>.appLanguage.load(initialValue: .english) ?? .english
        localizer.setCurrrentLanguage(language)
        
        #if !DEBUG
        isPerceptionCheckingEnabled = false
        #else
        isPerceptionCheckingEnabled = true
        #endif
    }
    
    // MARK: - App

    var body: some Scene {
        WindowGroup {
            GDEBankApplicationView(
                store: Store(
                    initialState: GDEBankApplicationState(
                        isUserAuthorized: sessionStorage.isAuthorized
                    ),
                    reducer: {
                        GDEBankApplication(
                            userDefaults: defaults,
                            sessionStorage: sessionStorage,
                            notificationCenter: notificationCenter,
                            keychainService: keychainService
                        )
                    }
                )
            )
        }
    }
}

extension Container {
    
    func resolve<T>() -> T {
        resolve(T.self).unsafelyUnwrapped
    }
}
