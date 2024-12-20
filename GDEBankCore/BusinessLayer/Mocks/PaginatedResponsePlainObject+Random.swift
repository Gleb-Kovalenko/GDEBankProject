//
//  PaginatedResponsePlainObject+Random.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import Foundation
import TCANetworkReducers

// MARK: - PaginatedResponsePlainObject+Random

extension PaginatedResponsePlainObject {
    
    public static func infiniteRandom(
        pageSize: Int,
        page: Int,
        factory: (_ randomID: Int) -> Plain
    ) -> PaginatedResponsePlainObject {
        PaginatedResponsePlainObject(
            pagination: PaginationMetadataPlainObject(
                totalObjectCount: Int.max,
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
