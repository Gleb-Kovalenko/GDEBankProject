//
//  HistoryType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 24.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - HistoryType

public enum HistoryType: String, Equatable, Codable, CaseIterable {
    
    // MARK: - Cases
    
    case all
    case transfer
    case deposit
    case conversion
    
    // MARK: - Useful
    
    public var title: String {
        switch self {
        case .all:
            CoreLocalization.HistoryType.All.title
        case .transfer:
            CoreLocalization.HistoryType.Transfer.title
        case .deposit:
            CoreLocalization.HistoryType.Deposit.title
        case .conversion:
            CoreLocalization.HistoryType.Conversion.title
        }
    }
}
