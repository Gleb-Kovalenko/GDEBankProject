//
//  Bundle.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import Foundation
import TCANetworkReducers

// MARK: - Bundle

extension Bundle {

    /// Current framework's bundle instance
    public static var mediaViewing: Bundle {
        Bundle(for: BundleToken.self)
    }

    /// Obtain current version number
    public var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// Obtain current build version number
    public var buildVersionNumber: Int {
        if let string = infoDictionary?["CFBundleVersion"] as? String {
            return Int(string) ?? -1
        }
        return -2
    }

    public func decode<T: Codable>(json: String, to type: T.Type = T.self) -> [T] {
        guard let path = Bundle.main.url(forResource: json, withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func decode<T: Codable>(json: String, to type: T.Type = T.self) -> PaginatedResponsePlainObject<T> {
        guard let path = Bundle.main.url(forResource: json, withExtension: "json") else {
            fatalError("Cannot get \(json).json from bundle")
        }
        do {
            let data = try Data(contentsOf: path)
            let entities = try JSONDecoder().decode([T].self, from: data)
            return PaginatedResponsePlainObject(
                pagination: PaginationMetadataPlainObject(
                    totalObjectCount: entities.count,
                    pageCount: 1,
                    currentPage: 1,
                    perPage: entities.count
                ),
                array: entities
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

// MARK: - BundleToken

private final class BundleToken {

}
