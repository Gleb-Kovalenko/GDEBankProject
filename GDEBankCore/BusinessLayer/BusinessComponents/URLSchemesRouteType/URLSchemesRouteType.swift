//
//  URLSchemesRouteType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 20.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - URLSchemesRouteType

public enum URLSchemesRouteType {
    
    // MARK: - Constants
    
    public enum Constants: Hashable {
        
        public static let isConnectAcceptedKey = "isConnectAccepted"
        public static let isConnectRequest = "isConnectRequets"
        public static let saltKey = "salt"
    }
    
    // MARK: - AppURLSchemeType
    
    public enum AppURLSchemeType: CaseIterable {
        
        // MARK: - Cases
        
        case gdeBankWallet
        case gdeBank
        
        // MARK: - Useful
        
        public var rootUrl: String {
            switch self {
            case .gdeBank:
                return "gde-bank-pay://"
            case .gdeBankWallet:
                return "gde-bank-wallet://"
            }
        }
        
        public var appStoreID: String {
            switch self {
            case .gdeBank:
                return AppConstants.Business.gdeBankAppStoreId
            case .gdeBankWallet:
                return AppConstants.Business.gdeBankWalletAppStoreId
            }
        }
    }
    
    // MARK: - Cases
    
    case openDaxiPay(isConnectAccepted: Bool)
    case openGDEBankWallet(isConnectRequest: Bool)
    
    // MARK: - Useful
    
    public var type: AppURLSchemeType {
        switch self {
        case .openGDEBankWallet:
            return .gdeBankWallet
        case .openDaxiPay:
            return .gdeBank
        }
    }
    
    public func buildURL() -> URL? {
        var urlString = ""
        urlString += type.rootUrl
        urlString += "?\(Constants.saltKey)=\(AppConstants.Business.urlSchemeSalt)"
        switch self {
        case let .openGDEBankWallet(isConnectRequest):
            urlString += "&\(Constants.isConnectRequest)=\(isConnectRequest)"
        case let .openDaxiPay(isConnectAccepted):
            urlString += "&\(Constants.isConnectAcceptedKey)=\(isConnectAccepted)"
        }
        print(urlString)
        return URL(string: urlString)
    }
}

// MARK: - Initializers

extension URLSchemesRouteType {
    
    // MARK: - Initializers
        
    /// Initializes `URLSchemesRouteType` from a given `URL`.
    /// - Parameter url: The URL to parse.
    public init?(url: URL) {
        
        /// Check if the scheme matches any known scheme
        guard let scheme = url.scheme,
              let schemeType = AppURLSchemeType.allCases.first(where: { $0.rootUrl.contains(scheme) }) else {
            return nil
        }
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems ?? []
        let parameters = Dictionary(uniqueKeysWithValues: queryItems.compactMap { ($0.name, $0.value) })
        guard let salt = parameters[Constants.saltKey], salt == AppConstants.Business.urlSchemeSalt else {
            return nil
        }
        
        switch schemeType {
        case .gdeBank:
            guard let isConnectAcceptString = parameters[Constants.isConnectAcceptedKey] ?? "",
                  let isConnectAccepted = Bool(isConnectAcceptString) else {
                return nil
            }
            self = .openDaxiPay(isConnectAccepted: isConnectAccepted)
        case .gdeBankWallet:
            guard let isConnectRequestString = parameters[Constants.isConnectRequest] ?? "",
                  let isConnectRequest = Bool(isConnectRequestString) else {
                return nil
            }
            self = .openGDEBankWallet(isConnectRequest: isConnectRequest)
        }
    }
}
