//
//  Double+Random.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 21.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - Double

extension Double {
    
    public static func randomAmount() -> Self {
        random(in: 0..<10_000)
    }
}
