//
//  DXPaginationPlainObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 22.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import TCANetworkReducers

// MARK: - DXPaginationPlainObject

public struct DXPaginationPlainObject<Plain: Equatable>: Equatable, PaginatedResponse {

    // MARK: - Properties

    /// Pagination info object
    public let pagination: DXPaginationMetadataPlainObject

    /// Array of paginated entities
    public let array: [Plain]
    
    // MARK: - Initializers
    
    public init(
        pagination: DXPaginationMetadataPlainObject,
        array: [Plain]
    ) {
        self.pagination = pagination
        self.array = array
    }
}

// MARK: - Decodable

extension DXPaginationPlainObject: Decodable where Plain: Decodable {}

// MARK: - Randomable

extension DXPaginationPlainObject {
    
    public static func infinityRandom(
        pageSize: Int,
        page: Int,
        factory: (_ randomID: Int) -> Plain
    ) -> DXPaginationPlainObject<Plain> {
        DXPaginationPlainObject(
            pagination: DXPaginationMetadataPlainObject(
                pageCount: Int.max / pageSize,
                currentPage: page,
                perPage: pageSize
            ),
            array: (0...pageSize).map {
                factory($0 + (page - 1) * pageSize)
            }
        )
    }
}

// MARK: - Randomable

extension DXPaginationPlainObject where Plain: Randomable {
    
    public static func infinityRandom(
        pageSize: Int,
        page: Int
    ) -> DXPaginationPlainObject<Plain> {
        infinityRandom(
            pageSize: pageSize,
            page: page,
            factory: { .random(id: $0) }
        )
    }
}
