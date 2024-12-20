//
//  Default.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 05.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - Default

public protocol Default {
    
    // MARK: - Properties
    
    static var `default`: Self { get }
}
