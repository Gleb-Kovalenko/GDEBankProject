//
//  Daemon.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 17.01.2024.
//

import Foundation

// MARK: - Daemon

public protocol Daemon {
    
    /// Start working
    func start()
    
    /// Stop working
    func stop()
}
