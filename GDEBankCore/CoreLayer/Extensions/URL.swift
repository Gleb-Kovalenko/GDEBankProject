//
//  URL.swift
//  GDEBank
//
//  Created by incetro on 1/20/24.
//

import Foundation

extension URL {
    
    var host: String {
        URLComponents(string: absoluteString)?.host?.replacingOccurrences(of: "www.", with: "") ?? absoluteString
    }
    
    public mutating func removeFirstQueryParameterIfNeeded() {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return
        }
        guard let queryItems = urlComponents.queryItems, queryItems.count == 1 else {
            return
        }
        let firstQueryItem = queryItems[0]
        if let firstValue = firstQueryItem.value {
            urlComponents.path += "/\(firstValue)"
        }
        urlComponents.queryItems = nil
        if let newUrlString = urlComponents.url?.absoluteString,
           let newURL = URL(string: newUrlString) {
            self = newURL
        }
        return
    }
    
    var isRemoteURL: Bool {
        absoluteString.isRemoteURL
    }
}
