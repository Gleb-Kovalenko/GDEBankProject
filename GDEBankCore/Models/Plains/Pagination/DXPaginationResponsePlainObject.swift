//
//  DXPaginationResponsePlainObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 22.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - DXPaginationResponsePlainObject

public struct DXPaginationResponsePlainObject<Plain: Equatable>: Equatable {

    // MARK: - Properties

    /// Pagination page count
    public let pageCount: Int

    /// Array of paginated entities
    public let array: [Plain]
    
    // MARK: - Initializers
    
    public init(pageCount: Int, array: [Plain]) {
        self.pageCount = pageCount
        self.array = array
    }
}

// MARK: - Decodable

extension DXPaginationResponsePlainObject: Decodable where Plain: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        self.pageCount = try responseContainer.decode(Int.self, forKey: .init(stringValue: "pageCount"))
        self.array = responseContainer.allKeys.compactMap { try? responseContainer.decode([Plain].self, forKey: $0) }.first ?? []
    }

    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case status
        case response
    }
    
    // MARK: - CodingKeys

    struct ResponseKeys: CodingKey {

        var stringValue: String
        var intValue: Int?

        init(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            nil
        }
    }
}

extension DXPaginationResponsePlainObject {
    
    func convert(page: Int, pageSize: Int) -> DXPaginationPlainObject<Plain> {
        DXPaginationPlainObject(
            pagination: DXPaginationMetadataPlainObject(
                pageCount: pageCount,
                currentPage: page,
                pageSize: pageSize
            ),
            array: array
        )
    }
}
