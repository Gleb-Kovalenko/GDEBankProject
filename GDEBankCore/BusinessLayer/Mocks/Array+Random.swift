//
//  Array+Random.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 16.08.2024.
//

import Foundation

// MARK: - Array+String

extension Array where Element == String {
    
    public static func randomPhoneNumber() -> [String] {
        [
            "+35722710000"
        ]
    }
}

// MARK: - Array + URL

extension Array where Element == URL {
    
    public static func randomWebsites() -> [URL] {
        [
            "https://www.apple.com"
        ]
        .compactMap(URL.init)
    }
    
    public static func randomPhotos() -> [URL] {
        let urlString = [""]
        return urlString.compactMap(URL.init)
    }
}
