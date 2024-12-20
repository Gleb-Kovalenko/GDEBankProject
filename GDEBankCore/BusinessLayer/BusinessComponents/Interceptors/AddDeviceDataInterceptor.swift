//
//  AddDeviceDataInterceptor.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 23.08.2024.
//

import HTTPTransport
import UIKit
import Foundation

// MARK: - AddDeviceDataInterceptor

public final class AddDeviceDataInterceptor {

    // MARK: - Parameters

    /// Bundle instance
    private let bundle: Bundle
    
    /// UIDevice instance
    private let device: UIDevice
    
    /// UserDefaults instance
    private let defaults: UserDefaults

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - bundle: Bundle instance
    public init(
        bundle: Bundle,
        device: UIDevice,
        defaults: UserDefaults
    ) {
        self.bundle = bundle
        self.device = device
        self.defaults = defaults
    }
}

// MARK: - HTTPRequestInterceptor

extension AddDeviceDataInterceptor: HTTPRequestInterceptor {

    public func intercept(request: URLRequest) -> URLRequest {
        var request = request
        request.allHTTPHeaderFields?[AppConstants.Network.Headers.client] = "iOS"
        request.allHTTPHeaderFields?[AppConstants.Network.Headers.build] = "\(bundle.buildVersionNumber)"
        request.allHTTPHeaderFields?[AppConstants.Network.Headers.device] = UIDevice.current.name
        request.allHTTPHeaderFields?[AppConstants.Network.Headers.osVersion] = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        request.allHTTPHeaderFields?[AppConstants.Network.Headers.locale] = defaults.retrieveLanguageCode()
        return request
    }
}
