//
//  String+Optional.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 18.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - String+Optional

extension Optional where Wrapped == String {
    
    public var emptyIfNil: String {
        self ?? ""
    }
}
