//
//  AddApiKeyTokenInterceptor.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 23.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import HTTPTransport

// MARK: - AddApiKeyTokenInterceptor

public final class AddApiKeyTokenInterceptor {

    // MARK: - Initializers

    public init() {}
}

// MARK: - HTTPRequestInterceptor

extension AddApiKeyTokenInterceptor: HTTPRequestInterceptor {

    public func intercept(request: URLRequest) -> URLRequest {
        var request = request
        request.allHTTPHeaderFields?[AppConstants.Network.Headers.apiKey] = AppConstants.Business.apiKey
        return request
    }
}
