//
//  AddAccessTokenInterceptor.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 23.08.2024.
//

import Foundation
import HTTPTransport

// MARK: - AddAccessTokenInterceptor

public final class AddAccessTokenInterceptor {

    // MARK: - Properties

    /// SessionStorage instance
    private let sessionStorage: SessionStorage

    // MARK: - Initializers

    public init(sessionStorage: SessionStorage) {
        self.sessionStorage = sessionStorage
    }
}

// MARK: - HTTPRequestInterceptor

extension AddAccessTokenInterceptor: HTTPRequestInterceptor {

    public func intercept(request: URLRequest) -> URLRequest {
        var request = request
        if let accessToken = self.sessionStorage.session()?.accessToken,
           request.allHTTPHeaderFields?.contains(where: { $0.key == AppConstants.Network.Headers.accessToken}) == false {
            request.allHTTPHeaderFields?[AppConstants.Network.Headers.accessToken] = "Bearer " + accessToken
        }
        return request
    }
}
