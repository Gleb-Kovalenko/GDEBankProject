//
//  DXPaginationMetadataPlainObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 22.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import TCANetworkReducers

// MARK: - DXPaginationMetadataPlainObject

public struct DXPaginationMetadataPlainObject: PaginationMetadata {

    // MARK: - Properties
    
    /// True if pagination has more objects
    public var hasMore: Bool {
        guard perPage > 0 else { return false }
        return currentPage < pageCount || currentPage == 0 && pageCount == 0
    }

    /// Total pages count
    public let pageCount: Int

    /// Current pagination page
    public let currentPage: Int

    /// Page size
    public let perPage: Int
}

// MARK: - Initializers

extension DXPaginationMetadataPlainObject {
    
    public init(
        pageCount: Int,
        currentPage: Int,
        pageSize: Int
    ) {
        self.pageCount = pageCount
        self.currentPage = currentPage
        self.perPage = pageSize
    }
    
    public init(perPage: Int) {
        self.init(
            pageCount: 0,
            currentPage: 0,
            pageSize: perPage
        )
    }
}
