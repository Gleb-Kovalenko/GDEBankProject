//
//  LocalizationStore.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 29.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - LocalizationStore

public protocol LocalizationStore {
    
    // MARK: - Properties
    
    /// Localization store locale
    static var locale: Locale? { get set }
    
    /// Localization store bundle
    static var bundle: Bundle? { get set }
}
