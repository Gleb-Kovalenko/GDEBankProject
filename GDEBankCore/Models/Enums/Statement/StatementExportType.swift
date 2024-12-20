//
//  StatementExportType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 04.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - StatementExportType

public enum StatementExportType: String, Equatable, CaseIterable {
    
    // MARK: - Cases
    
    case pdf
    case excel
    
    // MARK: - Useful
    
    public var title: String {
        switch self {
        case .pdf:
            "PDF"
        case .excel:
            "Excel"
        }
    }
}
