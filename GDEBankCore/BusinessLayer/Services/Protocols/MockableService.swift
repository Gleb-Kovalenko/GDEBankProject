//
//  MockableService.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 22.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - MockableService

public protocol MockableService {
    
    func mock<Output>(_ output: Output, with delay: Double) async throws -> Output
}

// MARK: - Default

extension MockableService {
    
    public func mock<Output>(_ output: Output, with delay: Double = .random(in: 1.75...2.2)) async throws -> Output {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        return output
    }
}
