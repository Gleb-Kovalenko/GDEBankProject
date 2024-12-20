//
//  LogInObserver.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import Combine

// MARK: - LogInObserver

public final class LogInObserver: ObservableObject {
    
    // MARK: - Singlton
    
    public static let shared = LogInObserver()
    
    // MARK: - Properties
    
    @Published public var isLogined: Bool? = nil
    
    // MARK: - Initializer
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogin), name: .login, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .logout, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - NotificationHandlers
    
    @objc private func handleLogin() {
        isLogined = true
    }
    
    @objc private func handleLogout() {
        isLogined = false
    }
}

