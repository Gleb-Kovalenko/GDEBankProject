//
//  AvailableStatementPeriod.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 03.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - AvailableStatementPeriod

public enum AvailableStatementPeriod: String, Identifiable, Equatable, CaseIterable {
    
    // MARK: - Cases
    
    case threeMonth
    case sixMonth
    case oneYear
    
    // MARK: - Useful
    
    public var id: String {
        rawValue
    }
    
    public var title: String {
        switch self {
        case .threeMonth:
            L10n.months(3)
        case .sixMonth:
            L10n.months(6)
        case .oneYear:
            L10n.years(1)
        }
    }
    
    public var months: Int {
        switch self {
        case .threeMonth:
            return 3
        case .sixMonth:
            return 6
        case .oneYear:
            return 12
        }
    }
}
