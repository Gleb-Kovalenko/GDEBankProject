//
//  AddNecessarySlashInterceptor.swift
//  GDEBank
//
//  Created by incetro on 1/7/24.
//

import Foundation
import HTTPTransport

// MARK: - AddNecessarySlashInterceptor

public final class AddNecessarySlashInterceptor {
    
    // MARK: - Initializers
    
    public init() {
        
    }
}

// MARK: - HTTPRequestInterceptor

extension AddNecessarySlashInterceptor: HTTPRequestInterceptor {
    
    public func intercept(request: URLRequest) -> URLRequest {
        var request = request
        if var url = request.url {
            if !url.absoluteString.hasSuffix("/"), !url.absoluteString.contains("?") {
                url = URL(string: url.absoluteString + "/").unsafelyUnwrapped
            }
            if !url.absoluteString.contains("/?"), url.absoluteString.contains("?") {
                url = URL(string: url.absoluteString.replacingOccurrences(of: "?", with: "/?")).unsafelyUnwrapped
            }
            if url.absoluteString.last == "/" && url.absoluteString.contains("profile/history/check/") {
                url = URL(string: String(url.absoluteString.dropLast())).unsafelyUnwrapped
            }
            request.url = url
        }
        return request
    }
}
